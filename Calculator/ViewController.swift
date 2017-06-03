//
//  ViewController.swift
//  Calculator
//
//  Created by Reyhan Sofian on 6/1/17.
//  Copyright © 2017 Reyhan Sofian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var userIsTyping = false
    
    @IBOutlet private weak var display: UILabel!

    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTyping {
            let textInDisplay = display.text!
            display.text = textInDisplay + digit
        } else {
            display.text = digit
        }
        
        userIsTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsTyping {
            brain.setOperand(operand: displayValue)
            userIsTyping = false
        }
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathSymbol)
        }
        
        displayValue = brain.result
    }
}

