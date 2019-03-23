//
//  TableViewController.swift
//  VKVideoSearch
//
//  Created by User on 11.03.2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var countOfVideos: Int!
    var videos: [videoModel] = []
    var word: String! = ""
    let tableView = UITableView()
    let searchBar = UISearchBar()
    var method = "get"
    var cellIdentifier = "TableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNewVideos(word: "", num: 0, method: method)
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        let doneButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(TableViewController.cancel))
        self.navigationItem.setRightBarButton(doneButton, animated: true)
        
        //Создание searchBar
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Поиск..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        self.searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        //Создание tableView
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        tableView.estimatedRowHeight = 100.0
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
        if (indexPath.row == (videos.count-10)) && (videos.count != countOfVideos!) {
            getNewVideos(word: word, num: videos.count, method: method)
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell()}
        
        cell.duration.text = videos[indexPath.row].duration!
        cell.title.text = videos[indexPath.row].title!
        cell.imageVideo.image = nil
        let imageURL: URL = URL(string: videos[indexPath.row].imageURL!)!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            if let data = try? Data(contentsOf: imageURL){
                DispatchQueue.main.async {
                        cell.imageVideo.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    
    // MARK: - SearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.videos.removeAll()
        tableView.reloadData()
        self.word = self.searchBar.text!
        self.searchBar.endEditing(true)
        method = "search"
        getNewVideos(word: word, num: 0, method: method)
    }
    
    // MARK: - Functions
    
    @objc func cancel() {
        self.videos.removeAll()
        tableView.reloadData()
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
        method = "get"
        tableView.reloadData()
        getNewVideos(word: word, num: 0, method: method)
    }
    
    func getNewVideos(word: String, num: Int, method: String) {
        videoModel.getVideos(word: word, num: num, method: method){result, count in
            DispatchQueue.main.async {
                self.videos.append(contentsOf: result)
                self.countOfVideos = count
                self.tableView.reloadData()
            }
        }
    }
}





