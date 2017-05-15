//
//  ViewController.swift
//  Buggy
//
//  Created by Alisher Abdukarimov on 5/15/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func buttonTapped(_ sender: UIButton) {
    print("Method \(#function) in file \(#file) line \(#line) called")
        
        badMethod()
    
    }
//    @IBAction func buttonTapped(_ sender: UIButton!) {
//        
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func badMethod() {
        let array = NSMutableArray()
        
        for i in 0..<10 {
            array.insert(i, at: i)
        }
        
        for _ in 0..<10 {
            array.removeObject(at: 0)
        }
    }


}

