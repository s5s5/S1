//
//  AboutViewController.swift
//  BullsEye
//
//  Created by s5s5 on 15/5/14.
//  Copyright (c) 2015年 s5s5. All rights reserved.
//

import UIKit

// 关于

class AboutViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var webView: UIWebView!
  @IBOutlet weak var parentalGates: UIView!
  @IBOutlet weak var num1: UILabel!
  @IBOutlet weak var num2: UILabel!
  @IBOutlet weak var num3: UITextField!
  var num1Value: Int = 0
  var num2Value: Int = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    parentalGates.hidden = true

    // 加载页面
    if let htmlFile = NSBundle.mainBundle().pathForResource("BullsEye",
        ofType: "html") {
      let htmlData = NSData(contentsOfFile: htmlFile)
      let baseURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
      webView.loadData(htmlData, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
    }

  }


  // 关闭ABOUT页,带动画
  @IBAction func close() {
    dismissViewControllerAnimated(true, completion: nil)
  }


  @IBAction func sendMail(sender: AnyObject) {
    parentalGates.hidden = false
    num1Value = Int(arc4random_uniform(6))
    num2Value = Int(arc4random_uniform(5))
    num1.text = String(num1Value)
    num2.text = String(num2Value)
    num3.becomeFirstResponder()

  }


  @IBAction func closeMail(sender: AnyObject) {
    num3.resignFirstResponder()
    parentalGates.hidden = true
  }

  func textFieldShouldReturn(num3: UITextField) -> Bool {
    var num3Value = num3.text
    var temp = String(num1Value + num2Value)
    if (num3Value == temp) {
      mailTo()
    }
    closeMail(0)
    return true
  }

  // 通过WEB方式调起MAIL反馈
  func mailTo() {
    var email = "musuisui@gmail.com"
    var tit = "Feedback%20for%20Firefighting(S1)"
    var body = "Feature%20request%20or%20bug%20report?"
    var url = NSURL(string: "mailto:\(email)?subject=\(tit)&body=\(body)")
    UIApplication.sharedApplication().openURL(url!)
  }

}
