//
//  ViewController.swift
//  Calculator
//
//  Created by Sarvad shetty on 12/2/17.
//  Copyright © 2017 Sarvad shetty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Variables
    var numberOnScreen :Double = 0
    var prevNumber:Double = 0
    var performingOp :Bool = false
    var operatorationNo :Int = 0
    
    //MARK: Outlets
    @IBOutlet weak var textLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    
    @IBAction func opButtonPressed(_ sender: UIButton) {
       
       
  
        if textLabel.text != "" && sender.tag != 17 && sender.tag != 10{
             prevNumber = Double(textLabel.text!)!
          
        if sender.tag == 13{
            textLabel.text = "/"
        }
        else if sender.tag == 14{
            textLabel.text = "x"
        }
        else if sender.tag == 15{
            textLabel.text = "-"
        }
        else if sender.tag == 16{
            textLabel.text = "+"
        }
            performingOp = true
            operatorationNo = sender.tag
        }
        else if sender.tag == 17{
            if operatorationNo == 13{
            
                textLabel.text = String(prevNumber / numberOnScreen)
            }
            else if operatorationNo == 14{
            
                textLabel.text = String(prevNumber * numberOnScreen)
            }
            else if operatorationNo == 15{
         
                textLabel.text = String(prevNumber - numberOnScreen)
            }
            else if operatorationNo == 16{
               
                textLabel.text = String(prevNumber + numberOnScreen)
            }
        }
        else if sender.tag == 10{
            textLabel.text = ""
            performingOp = false
            operatorationNo = 0
        }
        else if sender.tag == 18{
            if textLabel.text?.isEmpty == true{
                textLabel.text = "0."
                print("ui")
            }
          
        }

    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        if performingOp == true{
            textLabel.text = String(sender.tag)
            numberOnScreen = Double(textLabel.text!)!
            performingOp = false
            
        }
        else{
            textLabel.text = textLabel.text! + String(sender.tag)
            numberOnScreen = Double(textLabel.text!)!
        }
    }
    
}

