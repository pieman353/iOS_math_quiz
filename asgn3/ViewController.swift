
//  ViewController.swift
//  asgn3
//
//  Created by Adam Piekarski on 2/26/19.
//  Copyright © 2019 Adam Piekarski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        labels = [label1, label2, label3]
        textFields = [textField1, textField2, textField3]
        textField1.tag = 1
        textField2.tag = 2
        textField3.tag = 3
        numCorrectLabel.isHidden = true
        //labels = [label1, label2, label3]
    }
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var numCorrectLabel: UILabel!
    
    var labels: [UILabel?] = [nil, nil, nil]
    var textFields: [UITextField?] = [nil, nil, nil]
    var answers = [0, 0, 0]
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func generateExpressions() {
        for (index, label) in labels.enumerated() {
            let num1 = Int.random(in: 0 ... 10)
            let num2 = Int.random(in: 0 ... 10)
            switch index {
            case 0:
                answers[index] = num1 + num2
                label!.text = "\(num1) + \(num2)"
            case 1:
                answers[index] = num1 - num2
                label!.text = "\(num1) - \(num2)"
            case 2:
                answers[index] = num1 * num2
                label!.text = "\(num1) * \(num2)"
            default:
                break
            }
        }
        
    }
    
    func clearText() {
        for field in textFields {
            field!.text = ""
        }
    }
    
    func numCorrect() {
        var correctAnswers = 0
        print(answers)
        print(textFields.count)
        for (index, field) in textFields.enumerated() {
            print("\(index + 1). \(field!.text!)")
            if field!.text == "?" {
                continue
            }
            else if Int(field!.text!) == nil {
                continue
            }
            else if Int(field!.text!) == answers[index] {
                correctAnswers += 1
            }
        }
        numCorrectLabel.text = "Correct answers: \(correctAnswers)"
        numCorrectLabel.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func pressSubmit(_ sender: Any) {
        numCorrect()
        for field in textFields {
            field!.isUserInteractionEnabled = false
        }
    }
    @IBAction func pressNext(_ sender: Any) {
        generateExpressions()
        clearText()
        numCorrectLabel.isHidden = true
        for field in textFields {
            field!.isUserInteractionEnabled = true
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string:String) -> Bool {
        let index = textField.tag
        print(index)
        if textField.text == "" && string == "0" {
            return false
        }
        return true
    }
}

