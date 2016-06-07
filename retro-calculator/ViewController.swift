//
//  ViewController.swift
//  retro-calculator
//
//  Created by Mike on 6/6/16.
//  Copyright © 2016 Devshop. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "X"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)

        do {
            btnSound = try AVAudioPlayer(contentsOfURL: soundUrl)
            guard let btnSound = btnSound else { return }
            
            btnSound.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        
    
    }

    @IBAction func buttonPressed(btn: UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)

    }
    
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)

    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)

    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)

    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty  {
            //a user selected an operator but then selected another operator without first entering a number
            if runningNumber != "" {
                //do math

                rightValString = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                }
                
                leftValString = result
                outputLbl.text = result
                
            }

            currentOperation = op
            
        } else {
            //this is the first time an operator has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
        
    }
    
    
    func playSound() {
        if btnSound!.playing {
            btnSound!.stop()
        }
        
        btnSound!.play()
    }
    
}

