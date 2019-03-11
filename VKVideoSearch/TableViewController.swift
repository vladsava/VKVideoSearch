//
//  TableViewController.swift
//  VKVideoSearch
//
//  Created by User on 11.03.2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource {

    var token: String!
    var model1: [[String: Any]] = []
    let tableView = UITableView()
    
    fileprivate let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func getVideos(word: String, num: Int) {
        let sourceURL = "https://api.vk.com/method/video.search?access_token=\(String(token))&q=\(word)&sort=2&adult=0&offset=\(num)&count=40&v=5.92"
        print("\(sourceURL)")
        let encodedSourceURL = sourceURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        print("\(encodedSourceURL!)")
        session.dataTask(with: URL(string: encodedSourceURL!)!) { data, resp, err in
            guard err == nil else {
                print("error getting file: \(err!)")
                return
            }
            
            guard let data = data, let _models = try? JSONSerialization.jsonObject(with: data, options: .allowFragments), let models = _models as? [String: Any] else {
                return
            }
            //print("2")
            //print("\(models)")
            self.model1 = (models["response"] as? [String: Any])?["items"] as! [[String : Any]]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        print("\(token)")
        self.navigationItem.hidesBackButton = true
        let logOutButton = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(TableViewController.logOut(_:)))
        self.navigationItem.setRightBarButton(logOutButton, animated: true)
        
        //Создание tableView
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        tableView.dataSource = self
        getVideos(word: "natural", num: 0)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOut(_ sender: Any) {
        print("logout")
    }
    
    // MARK: - Navigation
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = model1[indexPath.row]["title"] as? String
        
        return cell
    }
}

    



