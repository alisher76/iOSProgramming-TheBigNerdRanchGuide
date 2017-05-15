//
//  Item.swift
//  Homepwner:Chapter 10...18
//
//  Created by Alisher Abdukarimov on 5/15/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit


class Item: NSObject {
    var name: String
    var valueInDollar: Int
    var serialNumber: String?
    let dateCreated: Date
    
    init(name: String, valueInDollar: Int, serialNumber: String?) {
        self.name = name
        self.valueInDollar = valueInDollar
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjective = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var idx = arc4random_uniform(UInt32(adjective.count))
            let randomAdjective = adjective[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName, valueInDollar: randomValue, serialNumber: randomSerialNumber)
        }else{
            self.init(name: "", valueInDollar: 0, serialNumber: nil)
        }
    }
}
