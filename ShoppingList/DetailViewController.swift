//
//  DetailViewController.swift
//  ShoppingList
//
//  Created by Shawn D. Hedgepeth on 10/26/20.
//  Copyright © 2020 Shawn D. Hedgepeth. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    var item: Item!
    
    @IBOutlet var itemNameTextField: UITextField!
    @IBOutlet var itemAmountTextField: UITextField!
    @IBOutlet var itemPriceTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        itemNameTextField.text = item.name
        itemAmountTextField.text = item.amount
        print(item.price)
        if let price = item.price {
            itemPriceTextField.text = String(price)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func submitChanges(_ sender: UIBarButtonItem) {
        if let name = itemNameTextField.text {
            item.name = name
        }
        if let amount = itemAmountTextField.text {
            item.amount = amount
        }
        if let price = itemPriceTextField.text {
            print(price)
            item.price = Float(price)
        }
    }
}
