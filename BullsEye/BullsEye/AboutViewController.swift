//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Haris Dizdarevic on 03/09/2017.
//  Copyright © 2017 Haris Dizdarevic. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
  @IBOutlet weak var webView: UIWebView!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
          if let htmlData = try? Data(contentsOf: url) {
            let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
            webView.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
          }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func close() {
    dismiss(animated: true, completion: nil)
  }
}
