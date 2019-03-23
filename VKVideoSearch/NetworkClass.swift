//
//  NetworkClass.swift
//  VKVideoSearch
//
//  Created by User on 22.03.2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

fileprivate let session = URLSession(configuration: URLSessionConfiguration.default)

class NetworkClass: NSObject {
    
    static func getVideoModels(word: String, num: Int, method: String, completionHandler: @escaping (_ result: [[String : Any]],_ count: Int?) -> ()) {
        
        guard let token = UserDefaults.standard.string(forKey: "AccessToken") else {return}
        let sourceURL = (method=="search" ? "https://api.vk.com/method/video.search?access_token=\(token)&q=\(word)&sort=2&adult=0&offset=\(num)&count=40&v=5.92" : "https://api.vk.com/method/video.get?access_token=\(token)&offset=\(num)&count=40&v=5.92")
        let encodedSourceURL = sourceURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        session.dataTask(with: URL(string: encodedSourceURL!)!) { data, resp, err in
            guard err == nil else {
                print("error getting file: \(err!)")
                return
            }
            
            guard let data = data, let _models = try? JSONSerialization.jsonObject(with: data, options: .allowFragments), let models = _models as? [String: Any] else {
                return
            }
            
            if models["error"]==nil {
                let countOfVideos = (models["response"] as? [String: Any])?["count"] as? Int
                let model = (models["response"] as? [String: Any])?["items"] as? [[String : Any]] ?? []
                completionHandler(model, countOfVideos)
            } else {print("Error")}
            }.resume()
    }
    
}
