//
//  Product.swift
//  lashu_9
//
//  Created by Lasha Tavberidze on 27.11.24.
//

import Foundation

struct Product{
    var name: String
    var quantity: Double
    var price: Double
    var category: Category
    var calculatedPrice: Double{
        return quantity * price
    }
    enum Category: Int{
        case meat = 1
        case pastry
        case drinks
        case fruit
        
      static func getSelectedCategory(for picked: String) -> Category{
            switch picked{
            case "meat": return .meat
            case "pastry": return .pastry
            case "drinks": return .drinks
            case "fruit": return .fruit
            default: return .meat
            }
        }
    }
    init(name: String, quantity: Double, price: Double, category: Category) {
        self.name = name
        self.quantity = quantity
        self.price = price
        self.category = category
    }
    
}
