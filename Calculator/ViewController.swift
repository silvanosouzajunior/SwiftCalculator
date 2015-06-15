//
//  ViewController.swift
//  Calculator
//
//  Created by vntsiju on 6/10/15.
//  Copyright (c) 2015 SilvanoJunior. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var display: UILabel!
    @IBOutlet var historicalDisplay: UILabel!
    
    var userIsInTheMiddeOfTypingANumber = false
    var brain = CalculatorBrain()
    let locale = NSLocale(localeIdentifier: "en_US")
    let formater = NSNumberFormatter()
    let M_PI = 3.14
    
    var decimalWasTyped = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        historicalDisplay.text = historicalDisplay.text! + sender.currentTitle!
        
        if(sender.currentTitle! == "π"){
            display.text = "\(M_PI)"
        }
        
        else {
            if userIsInTheMiddeOfTypingANumber{
                display.text = display.text! + digit
            } else {
                display.text = digit
                userIsInTheMiddeOfTypingANumber = true
            }
        }
    }

    @IBAction func operate(sender: UIButton) {
        historicalDisplay.text = historicalDisplay.text! + sender.currentTitle!
        
        if userIsInTheMiddeOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
        
        decimalWasTyped = false
        
    }
    
    @IBAction func enter() {
        historicalDisplay.text = historicalDisplay.text! + " "
        
        userIsInTheMiddeOfTypingANumber = false
        decimalWasTyped = false
        
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            formater.locale = locale
            return formater.numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddeOfTypingANumber = false
        }
    }
        
    @IBAction func decimalValue(sender: UIButton) {
        if decimalWasTyped == false {
            display.text = display.text! + sender.currentTitle!
            
            decimalWasTyped = true
            userIsInTheMiddeOfTypingANumber = true
        }
    }
}

  