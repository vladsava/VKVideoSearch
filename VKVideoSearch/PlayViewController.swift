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
    var video: videoModel?
    var webViewHeighAchorConstraint: NSLayoutConstraint? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        //Добавляем проигрыватель видео
        let videoURL = video?.player
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
        titleLabel.text = video?.title
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
        durationLabel.text = video?.duration
        durationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        durationLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 10).isActive = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.navigationController?.navigationBar.isHidden = true
            self.view.removeConstraint(webViewHeighAchorConstraint!)
            webViewHeighAchorConstraint = webView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1)
            webViewHeighAchorConstraint?.isActive = true
            
        } else {
            self.navigationController?.navigationBar.isHidden = false
            self.view.removeConstraint(webViewHeighAchorConstraint!)
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
