//
//  PostCell.swift
//  Instagram
//
//  Created by Kevin Chan on 9/14/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    var userId: Int!
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var postTextLabel: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        profileImageView = UIImageView(frame: CGRect(x: 12, y: 12, width: 50, height: 50))
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.layer.masksToBounds = true
        addSubview(profileImageView)
        
        nameLabel = UILabel(frame: CGRect(x: profileImageView.frame.origin.x + profileImageView.frame.width + 10, y: profileImageView.frame.origin.y, width: frame.width*0.75, height: 25))
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textAlignment = .left
        addSubview(nameLabel)
        
        timeLabel = UILabel(frame: CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y + nameLabel.frame.height, width: nameLabel.frame.width, height: nameLabel.frame.height))
        timeLabel.font = UIFont.systemFont(ofSize: 13)
        timeLabel.textAlignment = .left
        addSubview(timeLabel)
        
        
        postTextLabel = UILabel(frame: CGRect(x: 12, y: profileImageView.frame.origin.y + profileImageView.frame.height + 36, width: frame.width*0.9, height: frame.height - 74))
        postTextLabel.textAlignment = .left
        postTextLabel.font = UIFont.systemFont(ofSize: 13)
        postTextLabel.numberOfLines = 0
        postTextLabel.textColor = .gray
        addSubview(postTextLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
