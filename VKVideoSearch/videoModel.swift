//
//  videoModel.swift
//  VKVideoSearch
//
//  Created by User on 22.03.2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class videoModel: NSObject {
    
    var imageURL: String?
    var title: String?
    var duration: String?
    var player: String?
    
    static func getVideos(word: String, num: Int, method: String, completionHandler: @escaping (_ result: [videoModel],_ count: Int?) -> ()) {
        var videoArray: [videoModel] = []
        
        NetworkClass.getVideoModels(word: word, num: num, method: method) {result, count in
            for video in result {
                videoArray.append(videoModel.init(imageURL: video["photo_320"] as? String, title: video["title"] as? String, duration: (video["duration"] as? Int)?.asString(style: .abbreviated), player:  video["player"] as? String))
            }
            completionHandler(videoArray, count)
        }
    }
    
    override init() {
        super.init()
    }
    
    init(imageURL: String?, title: String?, duration: String?, player: String?) {
        super.init()
        self.imageURL = imageURL
        self.title = title
        self.duration = duration
        self.player = player
    }
    
}

extension Int {
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = style
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru")
        formatter.calendar = calendar
        guard let formattedString = formatter.string(from: TimeInterval(self)) else { return "" }
        return formattedString
    }
}
