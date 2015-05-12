//
//  ViewController.swift
//  BullsEye
//
//  Created by s5s5 on 15/5/2.
//  Copyright (c) 2015年 s5s5. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
    }

    func startNewRound() {
        round++
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 1 + Int(arc4random_uniform(100))
        slider.value = Float(currentValue);
    }

    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    @IBAction func showAlert() {
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference

        var title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }

        score += points

        let message = "You scored \(points) points"

        let alert = UIAlertController(title: title,
                message: message, preferredStyle: .Alert)

        let action = UIAlertAction(title: "OK", style: .Default,
                handler: {
                    // This closure tells the app to start a new round and
                    // update the labels when the alert is dismissed.
                    action in
                    self.startNewRound()
                    self.updateLabels()
                })

        alert.addAction(action)

        presentViewController(alert, animated: true, completion: nil)

    }

    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }

}

