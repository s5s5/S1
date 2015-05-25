//
//  AboutViewController.swift
//  BullsEye
//
//  Created by s5s5 on 15/5/14.
//  Copyright (c) 2015年 s5s5. All rights reserved.
//

import UIKit

// 关于

class AboutViewController: UIViewController {


  @IBOutlet weak var webView: UIWebView!

  override func viewDidLoad() {
    super.viewDidLoad()

    // 加载页面
    if let htmlFile = NSBundle.mainBundle().pathForResource("BullsEye",
        ofType: "html") {
      let htmlData = NSData(contentsOfFile: htmlFile)
      let baseURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
      webView.loadData(htmlData, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
    }

  }

  // 通过WEB方式调起MAIL反馈
  @IBAction func mailTo() {
    let email = "musuisui@gmail.com"
    let tit = "Feedback%20for%20Firefighting(S1)"
    let body = "Feature%20request%20or%20bug%20report?"
    let url = NSURL(string: "mailto:\(email)?subject=\(tit)&body=\(body)")
    UIApplication.sharedApplication().openURL(url!)
  }

  // 关闭ABOUT页,带动画
  @IBAction func close() {
    dismissViewControllerAnimated(true, completion: nil)
  }
}
