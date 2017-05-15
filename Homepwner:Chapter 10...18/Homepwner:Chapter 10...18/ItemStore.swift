//
//  ItemStore.swift
//  Homepwner:Chapter 10...18
//
//  Created by Alisher Abdukarimov on 5/15/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
                allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex ==  toIndex {
        return
        }
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        
        allItems.insert(movedItem, at: toIndex)
    }
    
}
