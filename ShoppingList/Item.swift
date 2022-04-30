//
//  Item.swift
//  ShoppingList
//
//  Created by Shawn D. Hedgepeth on 10/19/20.
//  Copyright © 2020 Shawn D. Hedgepeth. All rights reserved.
//

import UIKit

class Item: Equatable, Codable {
    var name: String
    var amount: String?
    var price: Float?
    
    init( name: String, amount: String?, price: Float?) {
        self.name = name
        self.amount = amount
        self.price = price
    }
    
    convenience init() {
        self.init(name: "", amount: nil, price: nil)
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getAmount() -> String? {
        return self.amount
    }
    
    func getPrice() -> Float? {
        return self.price
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setAmount(amount: String?) {
        self.amount = amount
    }
    
    func setPrice(price: Float?) {
        self.price = price
    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
            && lhs.amount == rhs.amount
            && lhs.price == rhs.price
    }
    
}
