//
//  ViewController.swift
//  eyexpopronative
//
//  Created by Thompson Sanjoto on 2018-07-12.
//  Copyright © 2018 eyexpo. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {

    @IBOutlet  var webView: WKWebView!
    var url:String?
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let ur = url,
            let myURL = URL(string:ur){
            
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }
        
    }
    
}

