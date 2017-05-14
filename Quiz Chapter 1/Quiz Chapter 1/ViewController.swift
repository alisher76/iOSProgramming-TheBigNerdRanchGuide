//
//  ViewController.swift
//  Quiz Chapter 1
//
//  Created by Alisher Abdukarimov on 5/13/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = [
        "What is 7+7",
        "What is the capital of Uzbekistan?",
        "What is cognac made from?"
    ]
    let answers: [String] = [
        "14",
        "Tashkent",
        "Grapes"
    ]
    
    var currentQuestionIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = questions[currentQuestionIndex]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showNextQuestion(_ sender: UIButton) {
    currentQuestionIndex += 1
        if currentQuestionIndex == questions.count{
            currentQuestionIndex = 0
        }
        
        let questionString = questions[currentQuestionIndex]
        questionLabel.text = questionString
        answerLabel.text = "???"
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        let answerString = answers[currentQuestionIndex]
        answerLabel.text = answerString
    }


}

