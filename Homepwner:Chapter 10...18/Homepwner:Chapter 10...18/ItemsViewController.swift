//
//  ItemsViewController.swift
//  Homepwner:Chapter 10...18
//
//  Created by Alisher Abdukarimov on 5/15/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the height of the status bar
        
        let heightOfTheStatusBar = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: heightOfTheStatusBar, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollar)"
        
        return cell
    }
    
}
