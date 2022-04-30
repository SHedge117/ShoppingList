//
//  ItemsViewController.swift
//  ShoppingList
//
//  Created by Shawn D. Hedgepeth on 10/23/20.
//  Copyright © 2020 Shawn D. Hedgepeth. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var storeNameTextField: UITextField!
    @IBOutlet var itemsViewTitle: UINavigationItem!
    
    var store: Store!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        itemsViewTitle.title = store.name
        storeNameTextField.text = store.name
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        store.name = storeNameTextField.text ?? ""
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.itemsList.count
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            store.name = text
            itemsViewTitle.title = text
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item = store.itemsList[indexPath.row]
        cell.nameLabel.text = item.name
        
        if item.amount == nil {
            cell.amountLabel.text = ""
        } else {
            cell.amountLabel.text = item.amount
        }
        if item.price == nil {
            cell.priceLabel.text = ""
        } else {
            if let price = item.price{
                cell.priceLabel.text = String(price)
            }
        }
        
        return cell
    }
    
    func addNewItem() {
        store.createItem()
        
        let indexPath = IndexPath(row: store.itemsList.count - 1, section: 0)
            
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            addNewItem()
            let index = store.itemsList.count - 1
            let item = store.itemsList[index]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.item = item
        }
        else if segue.identifier == "showItem" {
            if let row = tableView.indexPathForSelectedRow?.row {
                
                let item = store.itemsList[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        }
        else{
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = store.itemsList[indexPath.row]
            store.removeItem(item)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        store.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
}
