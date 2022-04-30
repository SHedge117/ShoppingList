//
//  Store.swift
//  ShoppingList
//
//  Created by Shawn D. Hedgepeth on 10/19/20.
//  Copyright © 2020 Shawn D. Hedgepeth. All rights reserved.
//

import UIKit

class Store: Equatable, Codable {
    
    var name: String
    var itemsList: [Item]
    
    init(name: String){
        self.name = name
        self.itemsList = []
    }
    
    convenience init() {
        self.init(name: "")
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item()
        itemsList.append(newItem)
        
        return newItem
    }
    
    static func ==(lhs: Store, rhs: Store) -> Bool {
        return lhs.name == rhs.name
           && lhs.itemsList == rhs.itemsList
   }
    
    func removeItem(_ item: Item) {
        if let index = itemsList.firstIndex(of: item) {
            itemsList.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = itemsList[fromIndex]
        itemsList.remove(at: fromIndex)
        itemsList.insert(movedItem, at: toIndex)
    }
    
}
