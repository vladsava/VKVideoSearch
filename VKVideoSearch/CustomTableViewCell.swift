//
//  CustomTableViewCell.swift
//  VKVideoSearch
//
//  Created by User on 12.03.2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    let imageVideo = UIImageView()
    let title = UILabel()
    let duration = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageVideo.backgroundColor = UIColor.lightGray
        
        imageVideo.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        duration.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageVideo)
        contentView.addSubview(title)
        contentView.addSubview(duration)
        
        title.numberOfLines = 2
        
        let viewsDict = [
            "image" : imageVideo,
            "title" : title,
            "duration" : duration,
            ]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(80)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-[duration]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(130)]-[title]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(130)]-[duration]", options: [], metrics: nil, views: viewsDict))
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
