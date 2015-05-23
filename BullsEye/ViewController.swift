//
//  ViewController.swift
//  BullsEye
//
//  Created by s5s5 on 15/5/2.
//  Copyright (c) 2015年 s5s5. All rights reserved.
//

import UIKit
import QuartzCore

// This is the main screen for the game. It has a view that shows a slider,
// several buttons and labels. It also handles all the game logic.

class ViewController: UIViewController {

  // This is the current value of the slider. Whenever the player drags the
  // slider, you update this variable with the new value.
  var currentValue = 0

  // At the start of each round, you calculate a random value and store it
  // in this variable. This is the value that the player has to try to set
  // on the slider.
  var targetValue = 0;

  // This variable keeps track of the player's score.
  var score = 0

  // These outlet variables are connected to the user interface elements (the
  // slider, labels and buttons) that you are interested in. By making outlets
  // for them you can refer to these controls from the code.
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var fireImage: UIImageView!
  @IBOutlet weak var emojiLabel: UILabel!
  @IBOutlet weak var Extinguisher: UIImageView!

  // This method is called while the app is starting up. At some point the main
  // view controller will be created. It will load its view from the storyboard
  // and connect the outlets to the view's user interface elements.
  //
  // When that is done, UIKit sends the viewDidLoad message to give you a chance
  // to do some initialization of our own before the app starts in earnest.
  //
  // You use this opportunity to set up the game and the labels and customize
  // the graphics for the slider.
  override func viewDidLoad() {
    super.viewDidLoad()


    let thumbImageNormal = UIImage(named: "Fire-engine1")
    slider.setThumbImage(thumbImageNormal, forState: .Normal)

    let thumbImageHighlighted = UIImage(named: "Fire-engine2")
    slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)


    if let transparentImage = UIImage(named: "Transparent") {
      slider.setMinimumTrackImage(transparentImage, forState: .Normal)
      slider.setMaximumTrackImage(transparentImage, forState: .Normal)

    }
    self.view.bringSubviewToFront(slider)

    startNewGame()
    updateLabels()

    fireImage.animationImages = [
        UIImage(named: "Fire1")!,
        UIImage(named: "Fire2")!,
        UIImage(named: "Fire3")!,
        UIImage(named: "Fire4")!
    ]
    fireImage.animationDuration = 0.8
    fireImage.startAnimating()

    Extinguisher.animationImages = [
        UIImage(named: "Extinguisher1")!,
        UIImage(named: "Extinguisher2")!
    ]
    Extinguisher.animationDuration = 1
    Extinguisher.startAnimating()

  }

  // This method is called when the player taps the "Hit Me!" button. It will
  // show the results for this round in an alert view popup.
  @IBAction func showAlert() {
    // Calculate how far off the slider's value is from the target value.
    // You use the abs() function to always make this a positive number.
    let difference = abs(currentValue - targetValue)
    // Calculate how many points the player has scored. The player gets more
    // points the closer he is to the target. The maximum score is 100 points.
    var points = 100 - difference

    // It's fun to change the title of the alert popup depending on how well
    // the player did. In addition, you give the player 100 bonus points if he
    // has a perfect score and 50 bonus points if he was very close.
    var title: String
    if difference < 10 {
      title = "😄😗🙇👏🏻👍🏻😍😻✌🏻"
      emojiLabel.text = "😄😗🙇👏🏻👍🏻😍😻✌🏻"
//      points += 100
    } else if difference < 30 {
      title = "👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻"
      emojiLabel.text = "👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻"
//      if difference == 1 {
//        points += 50
//      }
    } else if difference < 60 {
      title = "😙😙😙😙😙😙"
      emojiLabel.text = "😙😙😙😙😙😙"
    } else {
      title = "😂😂😂😂"
      emojiLabel.text = "😂😂😂😂"
    }

    // Add the points for this round to the total score.
    score += points

    // The message part of the alert view shows the number of points the player
    // has scored in this round. You use string interpolation to create this 
    // text string. The placeholder \(points) will be replaced by the value of
    // the points variable.
    let message = "🚒 🚑 🚓"

    // Now that you have the title and the message, you can finally create the
    // UIAlertController object and show it.
    let alert = UIAlertController(title: title,
        message: message, preferredStyle: .Alert)

    // The following code is called after the player pressed the OK button to 
    // close the alert.
    let action = UIAlertAction(title: "🚨", style: .Default,
        handler: {
          action in
          // This closure tells the app to start a new round and
          // update the labels when the alert is dismissed.
          // Start a new round and show it on the screen.
          self.startNewRound()
          self.updateLabels()
        })

    alert.addAction(action)

    // This shows the alert on the screen.
    presentViewController(alert, animated: true, completion: nil)

  }

  // This method is called when the player moves the slider.
  @IBAction func sliderMoved(slider: UISlider) {
    // The position of the slider is a value between 1 and 100, and may contain
    // digits after the decimal point. You round the value to a whole number and
    // store it in the currentValue variable.
    currentValue = lroundf(slider.value)
//    println(currentValue)

    // If you want to see the current value as you're moving the slider, then
    // uncomment the println() line below (remove the //) and keep an eye on the
    // output console when you run the app.

    //println("currentValue = \(currentValue)")
  }

  // This method is called when the player taps the "Start Over" button.
//  @IBAction func startOver() {
//    // Here you do the same thing that you did in viewDidLoad, which is: start 
//    // a new game (which also starts the first round) and update the labels to 
//    // show these changes on the screen.
//    startNewGame()
//    updateLabels()
//
//    // Create a Core Animation transition. This will crossfade from what is
//    // currently on the screen to the changes that you're making below.
//    let transition = CATransition()
//    transition.type = kCATransitionFade
//    transition.duration = 1
//    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//
//    // This makes the animation go.
//    view.layer.addAnimation(transition, forKey: nil)
//  }

  // This method starts a new game. It resets the score and the round number to
  // 0, and then calls the startNewRound method to begin the first round.
  func startNewGame() {
    score = 0
    startNewRound()
  }

  // This method starts a new round.
  func startNewRound() {
    // Increment the round number.
    // Calculate the new target value. You use the arc4random_uniform()
    // function to get a random number between 0 and 99 (inclusive), and then
    // add 1 to it to get a value between 1 and 100.
    if score == 0 {
      targetValue = 0;
    } else {
      targetValue = Int(arc4random_uniform(279))
    }

    // Reset the slider to its center position.
    currentValue = 278
    slider.value = Float(currentValue);
  }

  // This method puts the target value, the player's total score, and the current
  // round number on the labels. You placed this into a method of its own, so you
  // don't have to duplicate this code all the time.
  func updateLabels() {
    fireImage.frame.origin.x = CGFloat(targetValue);

  }


}

