//
//  PlayViewController.swift
//  VKVideoSearch
//
//  Created by User on 12.03.2019.
//  Copyright © 2019 User. All rights reserved.
//


import UIKit
import WebKit

class PlayViewController: UIViewController , WKNavigationDelegate{
    
    var webView : WKWebView!
    var video: [String: Any] = [:]
    var webViewHeighAchorConstraint: NSLayoutConstraint? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        //Добавляем проигрыватель видео
        let videoURL = video["player"]! as? String
        let url = URL(string: videoURL!)
        let request = URLRequest(url: url!)
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.load(request)
        self.view.addSubview(webView)
        
        webView.scrollView.isScrollEnabled = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        webViewHeighAchorConstraint = webView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
        webViewHeighAchorConstraint?.isActive = true
       
        //Добавляем поле для названия
        let titleLabel = UILabel()
        self.view.addSubview(titleLabel)
        titleLabel.text = video["title"]! as? String
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo:view.rightAnchor, constant: -10).isActive = true
        
        //Добавляем поле для длительности видео
        let durationLabel = UILabel()
        self.view.addSubview(durationLabel)
        durationLabel.textAlignment = .left
        durationLabel.textColor = UIColor.gray
        durationLabel.numberOfLines = 0
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        let time = (video["duration"]! as? Int)!
        var timeS = ""
        let hour = time/3600
        let min = time%3600/60
        let sec = time%60
        timeS+=(hour == 0 ? "" : "\(hour):")
        if (hour>0)&&(min<10) {timeS+="0\(min):"}
        else {timeS+="\(min):"}
        timeS+=(sec <= 9 ? "0\(sec)" : "\(sec)")
        durationLabel.text = timeS
        durationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        durationLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 10).isActive = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.navigationController?.navigationBar.isHidden = true
            webViewHeighAchorConstraint?.isActive = false
            webViewHeighAchorConstraint = webView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1)
            webViewHeighAchorConstraint?.isActive = true
        } else {
            self.navigationController?.navigationBar.isHidden = false
            webViewHeighAchorConstraint?.isActive = false
            webViewHeighAchorConstraint = webView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
            webViewHeighAchorConstraint?.isActive = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- WKNavigationDelegate
    
    
    
}
