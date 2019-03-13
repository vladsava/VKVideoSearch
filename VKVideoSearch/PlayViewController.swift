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
        webView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        webView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        webView.heightAnchor.constraint(greaterThanOrEqualTo: self.view.heightAnchor, multiplier: 0.35).isActive = true
       
        //Добавляем поле для названия
        let titleLabel = UILabel()
        self.view.addSubview(titleLabel)
        titleLabel.text = video["title"]! as? String
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
  /*      let horizontalConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute:NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: webView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 50)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint]) */
        
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
        let min = (video["duration"]! as? Int)!/60
        let sec = (video["duration"]! as? Int)!%60
        durationLabel.text = "\(min)"  + ":" + (sec <= 9 ? "0" : "") + "\(sec)"
        durationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        durationLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 10).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- WKNavigationDelegate
    
    
    
}
