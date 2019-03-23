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
        
        contentView.addSubview(imageVideo)
        imageVideo.backgroundColor = UIColor.lightGray
        imageVideo.translatesAutoresizingMaskIntoConstraints = false
        imageVideo.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageVideo.widthAnchor.constraint(equalToConstant: 130).isActive = true
        imageVideo.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        imageVideo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        imageVideo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        
        contentView.addSubview(title)
        title.numberOfLines = 2
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: imageVideo.trailingAnchor, constant: 10).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        
        contentView.addSubview(duration)
        duration.translatesAutoresizingMaskIntoConstraints = false
        duration.leadingAnchor.constraint(equalTo: imageVideo.trailingAnchor, constant: 10).isActive = true
        duration.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        duration.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
