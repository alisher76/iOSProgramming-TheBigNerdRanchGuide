//
//  DetailViewController.swift
//  Homepwner:Chapter 10...18
//
//  Created by Alisher Abdukarimov on 5/16/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class   DetailViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var serialTextField: UITextField!
    @IBOutlet var valueTextField: UITextField!
    @IBOutlet var dateCreatedLabel: UILabel!
    
    var item: Item!
    
    var numberFormatter: NumberFormatter = { 
    let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    
    let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.text = item.name
        serialTextField.text = item.serialNumber
        valueTextField.text = "$\(numberFormatter.string(from: NSNumber(value: item.valueInDollar))!)"
        dateCreatedLabel.text = "Date Created: \n\(dateFormatter.string(from: item.dateCreated))"
    }
    
    
}
