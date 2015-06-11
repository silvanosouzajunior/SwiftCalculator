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
        let operation = sender.currentTitle!
        
        decimalWasTyped = false
        
        if userIsInTheMiddeOfTypingANumber {
            enter()
        }
        
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $0 / $1 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $0 - $1 }
        case "√": performOperation { sqrt($0) }
        case "sin": performOperation { sin(CDouble($0)) }
        case "cos": performOperation { cos(CDouble($0)) }
        default: break
            
        }
    }
    
    private func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func multiply(op1: Double, op2:Double) -> Double {
        return op1 * op2
    }
    
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        historicalDisplay.text = historicalDisplay.text! + " "
        
        userIsInTheMiddeOfTypingANumber = false
        decimalWasTyped = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
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

  