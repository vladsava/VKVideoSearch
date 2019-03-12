//
//  TableViewController.swift
//  VKVideoSearch
//
//  Created by User on 11.03.2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var token: String!
    var model1: [[String: Any]] = []
    var videos: [[String: Any]] = []
    var word: String!
    let tableView = UITableView()
    let searchBar = UISearchBar()
    
    fileprivate let session = URLSession(configuration: URLSessionConfiguration.default)
    
    //Загрузка порции данных
    func getVideos(word: String, num: Int) {
        let sourceURL = "https://api.vk.com/method/video.search?access_token=\(String(token))&q=\(word)&sort=2&adult=0&offset=\(num)&count=40&v=5.54"
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
           
            if models["error"]==nil {
            self.model1 = (models["response"] as? [String: Any])?["items"] as! [[String : Any]]
            self.videos.append(contentsOf: self.model1)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                }
                
            } else {print("Error")}
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(TableViewController.searchBarSearchButtonClicked(_:)))
        self.navigationItem.setRightBarButton(doneButton, animated: true)
        
        //Создание searchBar
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Поиск..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        self.searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        //Создание tableView
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "TableCell")
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
    
    }
    
    // MARK: - Navigation
    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let playController = PlayViewController()
        playController.video = videos[indexPath.row]
        self.navigationController?.pushViewController(playController, animated: true)
    }
    
    // MARK: - TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == (videos.count-10) {
            getVideos(word: word, num: videos.count)
            print("i=\(indexPath.row)  v= \(videos.count) gogogogogo")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? CustomTableViewCell
        let min = (videos[indexPath.row]["duration"]! as? Int)!/60
        let sec = (videos[indexPath.row]["duration"]! as? Int)!%60
        cell?.duration.text = "\(min)"  + ":" + (sec <= 9 ? "0" : "") + "\(sec)"
        cell?.title.text = videos[indexPath.row]["title"] as? String
        
        let imageURL: URL = URL(string: videos[indexPath.row]["photo_130"] as! String)!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            if let data = try? Data(contentsOf: imageURL){
                DispatchQueue.main.async {
                    cell?.imageVideo.image = UIImage(data: data)
                }
            }
         }
        return cell!
    }
    
    // MARK: - SearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.videos.removeAll()
        tableView.reloadData()
        self.word = self.searchBar.text!
        self.searchBar.endEditing(true)
        getVideos(word: word, num: 0)
    }
    
}

    



