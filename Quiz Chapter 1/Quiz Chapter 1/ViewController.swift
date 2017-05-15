//
//  ViewController.swift
//  Quiz Chapter 1
//
//  Created by Alisher Abdukarimov on 5/13/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
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
        currentQuestionLabel.text = questions[currentQuestionIndex]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nextQuestionLabel.alpha = 0
        
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
        nextQuestionLabel.text = questionString
        answerLabel.text = "???"
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        let answerString = answers[currentQuestionIndex]
        answerLabel.text = answerString
    }
    
    func animateLabelTransitions() {
        view.layoutIfNeeded()
        
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animate(withDuration: 1,
            delay: 0,
            options: [.curveLinear],
            animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                
                self.view.layoutIfNeeded()
        },
            completion: { _ in
                swap(&self.currentQuestionLabel,
                     &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                self.updateOffScreenLabel()
        })
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }


}

