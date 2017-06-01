//
//  ViewController.swift
//  Calculator
//
//  Created by Reyhan Sofian on 6/1/17.
//  Copyright © 2017 Reyhan Sofian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isTyping = false
    
    @IBOutlet weak var display: UILabel!

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if isTyping {
            let textInDisplay = display.text!
            display.text = textInDisplay + digit
        } else {
            display.text = digit
        }
        
        isTyping = true
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        isTyping = false
        if let mathSymbol = sender.currentTitle {
            if mathSymbol == "π" {
                display.text = String(M_PI)
            }
        }

    }
}

