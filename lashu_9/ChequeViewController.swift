//
//  ChequeViewController.swift
//  lashu_9
//
//  Created by Lasha Tavberidze on 27.11.24.
//

import UIKit

class ChequeViewController: UIViewController, ChooseProductViewControllerDelegate {
    
    @IBOutlet weak var chequeIDLabel: UILabel!
    @IBOutlet weak var productsAmountLabel: UILabel!
    @IBOutlet weak var productsQuantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    private var productsWithId: [Int:[Product]] = [:]
    func didGetHoldOfProducts(_ products: [Int:[Product]]) {
        self.productsWithId = products
        print("Received products: \(products)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if productsAmountLabel?.text == nil{
            print("nil")
        }
        // Do any additional setup after loading the view.
        updateLabels()
    }
    
    func updateLabels(){
        var count = 0
        var quantityKg: Double = 0
        var calculated: Double = 0
        for (key, products) in productsWithId{
            chequeIDLabel?.text = String(key)
            for product in products{
                count += 1
                quantityKg += product.quantity
                calculated += product.calculatedPrice
            }
        }
        productsAmountLabel?.text = String(count)
        productsQuantityLabel?.text = String(quantityKg)
        totalPriceLabel?.text = String(calculated)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
