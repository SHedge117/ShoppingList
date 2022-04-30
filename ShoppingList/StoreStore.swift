//
//  StoreStore.swift
//  ShoppingList
//
//  Created by Shawn D. Hedgepeth on 10/19/20.
//  Copyright © 2020 Shawn D. Hedgepeth. All rights reserved.
//

import UIKit

class StoreStore {
    
    var allStores = [Store]()
    let storeArchiveURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("stores.plist")
    }()
    
    init() {
        do {
            let data = try Data(contentsOf: storeArchiveURL)
            let unarchiver = PropertyListDecoder()
            let stores = try unarchiver.decode([Store].self, from: data)
            allStores = stores
        }
        catch {
            print("Error reading  in saved Stores: \(error)")
        }
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
    }
    
    @discardableResult func createStore() -> Store {
        let newStore = Store()
        allStores.append(newStore)
        
        return newStore
    }
    
    func removeStore(_ store: Store) {
        if let index = allStores.firstIndex(of: store) {
            allStores.remove(at: index)
        }
    }
    
    func moveStore(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedStore = allStores[fromIndex]
        allStores.remove(at: fromIndex)
        allStores.insert(movedStore, at: toIndex)
    }
    
    @objc func saveChanges() -> Bool {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allStores)
            try data.write(to: storeArchiveURL, options: [.atomic])
            print("Saved all of the stores")
            return true
        } catch let encodingError {
            print("Error encoding allStores: \(encodingError)")
            return false
        }
    }
}
