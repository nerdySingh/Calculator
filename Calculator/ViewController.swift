//
//  ViewController.swift
//  Calculator
//
//  Created by Tanveer Anand on 07/05/17.
//  Copyright © 2017 Tanveer Anand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var displayLabel: UILabel! //it is the value that needs to be displayed on the screen.
    var typing = false //detects if user is typing or not initially false.
    @IBAction func touchDigit(_ sender: UIButton)
    { /* this is an action created on every button to detect which button was pressed in the viewController. */
        let button = sender.currentTitle! //When we press a button on the view controller the title of the button will be saved here.
        print("\(button) was pressed") //displays which button was pressed on the console.
        if typing
        {
            let currentText = displayLabel.text!
            displayLabel.text = currentText + button
        }
            /*
             if typing is true, if the user is putting digits in the label then the if condition will be executed, hence
             */
        else
        {
            displayLabel.text! = button //the first time the user is about to input values into the calculator.
            typing = true
        }
    }
    
    public var clickedDot = false
    @IBAction func dotWasClicked(_ sender: UIButton)
    {
        
       
        if typing
        {
            if clickedDot
            {
                displayLabel.text! = displayLabel.text!
                
            }
        
            
        else
            {
                let currentText = Int(displayLabel.text!)!
                displayLabel.text! = "\(String(describing: currentText))" + "."
                typing = true
                clickedDot = true
            }
        }

        
    }
    
    
    
    var displayValue : Double {
        get{
            return Double(displayLabel.text!)!
        }
        set{
            displayLabel.text! = String(newValue)
        }
    }
    
    
    private var brain = CalculatorBrain()
    /* 

     CalculatorBrain is a struct in the CalculatorBrain.swift file. variable brain now can access all the
     methods and public variables of the structure CalculatorBrain. To access them just add a "." to brain  eg-
     brain."method_name"/"public variable name".
     
     */

    @IBAction func specialSymbol(_ sender: UIButton) {
        
        //print(typing,displayLabel.text!)
        clickedDot = false
        if typing
        {
            brain.setOperand(displayValue)
            typing = false
        }
        /*
         typing is initially false, if no digit is pressed and we go with "π" the variable mathematical_symbol
         will be set, because our current sender: UIButton will be a symbol. 
         */
        if let mathematical_symbol = sender.currentTitle
        {
            brain.performOperation(mathematical_symbol)
            //calls the performOperation in the struct CalculatorBrain(). Now go to CalculatorBrain.swift.
        }
        
        if let result = brain.result
        {
            displayValue = result
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

