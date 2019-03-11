//
//  ViewController.swift
//  VKVideoSearch
//
//  Created by User on 11.03.2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    var loginView:WKWebView!
    var token: String!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        loginView = WKWebView(frame: .zero, configuration: webConfiguration)
        loginView.uiDelegate = self
        view = loginView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.navigationDelegate = self
        let myURL = URL(string:"https://oauth.vk.com/authorize?client_id=6895508&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=video&response_type=token&v=5.52")
        let myRequest = URLRequest(url: myURL!)
        loginView.load(myRequest)
        //6895508
        //6789060
        // Do any additional setup after loading the view, typically from a nib.
    }


}

