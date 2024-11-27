//
//  ChooseProductViewController.swift
//  lashu_9
//
//  Created by Lasha Tavberidze on 26.11.24.
//

import UIKit

class ChooseProductViewController: UIViewController{
    @IBOutlet weak var productAmountLabel: UILabel!
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var productQuantityTextField: UITextField!
    @IBOutlet weak var productPriceTextField: UITextField!
    @IBOutlet weak var productCategoryPickerButton: UIButton!
    weak var delegate: ChooseProductViewControllerDelegate?
    var addedProducts: [Product] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCategoryPicker()
    }
    @IBAction func didTapAddProductButton(_ sender: UIButton) {
        if !textFieldIsEmpty(){
            makeProductObject()
        }
    }
    @IBAction func didTapCalculateButton(_ sender: UIButton) {
        guard let chequeVC = storyboard?.instantiateViewController(identifier: "ChequeView") as? ChequeViewController else {print("Could not instantiate ChequeViewController")
            return }
        self.delegate = chequeVC
        let randomNum = Int.random(in: 1...1000000)
        let productsWithId: [Int:[Product]] = [randomNum: addedProducts]
        delegate?.didGetHoldOfProducts(productsWithId)
        navigationController?.pushViewController(chequeVC, animated: true)
    }
    
    //MARK: - functions
    
    func textFieldIsEmpty() -> Bool{
        let isEmpty = [productNameTextField?.text, productQuantityTextField?.text, productPriceTextField?.text]
            .contains(where: { $0?.isEmpty ?? true })
        return isEmpty
    }
    func makeProductObject(){
        let cat = Product.Category.getSelectedCategory(for: productCategoryPickerButton?.titleLabel?.text ?? "")
        let newProduct = Product(
            name: productNameTextField?.text ?? "",
            quantity: Double(productQuantityTextField?.text ?? "0") ?? 0.0,
            price: Double(productPriceTextField?.text ?? "0") ?? 0.0,
            category: cat)
        addedProducts.append(newProduct)
        updateProductAmountLabel()
    }
    
    func updateProductAmountLabel(){
        productAmountLabel?.text = "Product Amount: \(addedProducts.count)"
    }
    func setUpCategoryPicker(){
        let menuItem1 = UIAction(title: "meat") { _ in
            self.productCategoryPickerButton.setTitle("meat", for: .normal)
        }
        let menuItem2 = UIAction(title: "drinks") { _ in
            self.productCategoryPickerButton.setTitle("drinks", for: .normal)
        }
        let menuItem3 = UIAction(title: "pastry") { _ in
            self.productCategoryPickerButton.setTitle("pastry", for: .normal)
        }
        let menuItem4 = UIAction(title: "fruit") { _ in
            self.productCategoryPickerButton.setTitle("fruit", for: .normal)
        }
        let menu = UIMenu(title: "Category", children: [menuItem1, menuItem2, menuItem3, menuItem4])
        productCategoryPickerButton.menu = menu
        productCategoryPickerButton.showsMenuAsPrimaryAction = true
    }
}

// MARK: - protocol delegate for this class

protocol ChooseProductViewControllerDelegate: AnyObject {
    func didGetHoldOfProducts(_ products: [Int : [Product]])
}
