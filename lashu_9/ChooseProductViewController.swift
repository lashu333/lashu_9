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
        setupUI()
        configureTextFields()
        configureCategoryButton()
        configureActionButtons()
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
    func setUpTextFields(){
        productQuantityTextField?.keyboardType = .decimalPad
        productPriceTextField?.keyboardType = .decimalPad
    }
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
    
    
    // MARK: - UI
    private func configureTextFields() {
        let textFields = [
            productNameTextField,
            productQuantityTextField,
            productPriceTextField
        ]
        
        textFields.forEach { textField in
            textField?.backgroundColor = UIColor(hex: "#F7F9F9")
            textField?.layer.cornerRadius = 12
            textField?.layer.shadowColor = UIColor.black.cgColor
            textField?.layer.shadowOffset = CGSize(width: 0, height: 2)
            textField?.layer.shadowRadius = 4
            textField?.layer.shadowOpacity = 0.1
            textField?.borderStyle = .none
            textField?.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
            textField?.leftViewMode = .always
        }
    }
    private func configureCategoryButton() {
        productCategoryPickerButton.layer.cornerRadius = 12
        productCategoryPickerButton.backgroundColor = UIColor(hex: "#2ECC71")
        productCategoryPickerButton.setTitleColor(.white, for: .normal)
        productCategoryPickerButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    private func configureActionButtons() {
        let buttons = [
            view.subviews.first(where: { $0.tag == 1 }) as? UIButton,
            view.subviews.first(where: { $0.tag == 2 }) as? UIButton
        ]
        
        buttons.forEach { button in
            button?.layer.cornerRadius = 15
            button?.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
            button?.addTarget(self, action: #selector(buttonTouchAnimation), for: [.touchDown, .touchUpInside])
        }
    }
    
    @objc private func buttonTouchAnimation(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = sender.isTouchInside ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
        }
    }
    
    private func setupUI() {
        // Overall view styling
        view.backgroundColor = UIColor(hex: "#F2F4C7")
        
        // Add subtle gradient background if desired
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#F2F4C7").cgColor,
            UIColor(hex: "#F7F9F9").cgColor
        ]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - protocol delegate for this class

protocol ChooseProductViewControllerDelegate: AnyObject {
    func didGetHoldOfProducts(_ products: [Int : [Product]])
}
