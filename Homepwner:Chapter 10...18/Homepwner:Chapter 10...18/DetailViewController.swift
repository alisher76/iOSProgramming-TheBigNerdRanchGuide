//
//  DetailViewController.swift
//  Homepwner:Chapter 10...18
//
//  Created by Alisher Abdukarimov on 5/16/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class   DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var serialTextField: UITextField!
    @IBOutlet var valueTextField: UITextField!
    @IBOutlet var dateCreatedLabel: UILabel!
    
    var item: Item!{
        didSet {
        navigationItem.title = item.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.text = item.name
        serialTextField.text = item.serialNumber
        valueTextField.text = (numberFormatter.string(from: NSNumber(value: item.valueInDollar)))
        dateCreatedLabel.text = "Date Created: \n\(dateFormatter.string(from: item.dateCreated))"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        //SaveChangesToItem
        item.name = nameTextField.text ?? ""
        item.serialNumber = serialTextField.text
        
        if let valueText = valueTextField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollar = value.intValue
        }else{
            item.valueInDollar = 0
        }
        
    }
        
    
    
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
    
    //To dismiss keyboard by tapping return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
