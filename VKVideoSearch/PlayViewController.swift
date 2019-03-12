//
//  PlayViewController.swift
//  VKVideoSearch
//
//  Created by User on 12.03.2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import AVKit
import WebKit

class PlayViewController: UIViewController, WKUIDelegate {

    var videoURL: String!
    var videoView:WKWebView!
    
    fileprivate let session = URLSession(configuration: URLSessionConfiguration.default)
    
   
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        videoView = WKWebView(frame: .zero, configuration: webConfiguration)
        videoView.uiDelegate = self
        view = videoView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("\(videoURL!)")
        let myURL = URL(string:videoURL!)
        let myRequest = URLRequest(url: myURL!)
        videoView.load(myRequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
