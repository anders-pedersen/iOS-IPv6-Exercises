//
//  HelpViewController.swift
//  IP Prefix Sizes
//
//  Created by Anders Pedersen on 18/03/17.
//  Copyright © 2017 Anders Pedersen. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let localFilePath = Bundle.main.url(forResource: "quiz", withExtension: "html")
        let myRequest = URLRequest(url: localFilePath!)
        webView.load(myRequest)
    }

}
