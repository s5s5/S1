//
//  ViewController.swift
//  BullsEye
//
//  Created by s5s5 on 15/5/2.
//  Copyright (c) 2015年 s5s5. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue: Int = 0
    
    @IBOutlet weak var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
//        currentValue = lroundf(slider.value)
//        targetValue = 1 + Int(arc4random_uniform(100))
        startNewRound()
    }

    @IBAction func showAlert() {
        let message = "The value of the slider is: \(currentValue)"
                    + "\nThe target value is: \(targetValue)"

        let alert = UIAlertController(title: "Hello, World",
                message: message, preferredStyle: .Alert)

        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)

        alert.addAction(action)

        presentViewController(alert, animated: true, completion: nil)
        
        startNewRound()
    }

    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 1 + Int(arc4random_uniform(100))
        slider.value = Float(currentValue);
    }


}

