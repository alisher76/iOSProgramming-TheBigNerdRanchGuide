//
//  DetailViewController.swift
//  Homepwner:Chapter 10...18
//
//  Created by Alisher Abdukarimov on 5/16/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class   DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var serialTextField: UITextField!
    @IBOutlet var valueTextField: UITextField!
    @IBOutlet var dateCreatedLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var item: Item!{
        didSet {
        navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.text = item.name
        serialTextField.text = item.serialNumber
        valueTextField.text = (numberFormatter.string(from: NSNumber(value: item.valueInDollar)))
        dateCreatedLabel.text = "Date Created: \n\(dateFormatter.string(from: item.dateCreated))"
        let key = item.itemKey
        
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
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
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        imagePicker.sourceType = .camera
        }else{
        imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
       
        imageStore.setImage(image, forKey: item.itemKey)
        imageView.image = image
       
        
        dismiss(animated: true, completion: nil)
    }
    
}
