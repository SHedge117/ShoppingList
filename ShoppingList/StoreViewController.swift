//
//  StoreViewController.swift
//  ShoppingList
//
//  Created by Shawn D. Hedgepeth on 10/19/20.
//  Copyright © 2020 Shawn D. Hedgepeth. All rights reserved.
//

import UIKit

class StoreViewController: UITableViewController {
    
    var storeStore: StoreStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        if storeStore.allStores.count >= 1 {
            print(storeStore.allStores[0].name)
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeStore.allStores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath) as! StoreCell
        let store = storeStore.allStores[indexPath.row]
        cell.nameLabel.text = store.name
        if store.itemsList.count == 1 {
            cell.numLabel.text = "\(store.itemsList.count) item"
        }
        else{
            cell.numLabel.text = "\(store.itemsList.count) items"
        }
        return cell
    }
    
    func addNewStore() {
        storeStore.createStore()
        
        let indexPath = IndexPath(row: storeStore.allStores.count - 1, section: 0)
            
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addStore" {
            addNewStore()
            let index = storeStore.allStores.count - 1
            let store = storeStore.allStores[index]
            let itemsViewController = segue.destination as! ItemsViewController
            itemsViewController.store = store
        }
        else if segue.identifier == "showStore" {
            if let row = tableView.indexPathForSelectedRow?.row {
                
                let store = storeStore.allStores[row]
                let itemsViewController = segue.destination as! ItemsViewController
                itemsViewController.store = store
            }
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let store = storeStore.allStores[indexPath.row]
            storeStore.removeStore(store)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        storeStore.moveStore(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
}
