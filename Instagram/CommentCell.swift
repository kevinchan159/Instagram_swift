//
//  CommentCell.swift
//  Instagram
//
//  Created by Kevin Chan on 9/16/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    var user: User!
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var commentLabel: UILabel!
    var timeLabel: UILabel!
    
    var heartButton: UIButton!
    var isLiked: Bool = false
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        profileImageView = UIImageView(frame: CGRect(x: 12, y: 12, width: 50, height: 50))
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.layer.masksToBounds = true
        addSubview(profileImageView)
        
        nameLabel = UILabel(frame: CGRect(x: profileImageView.frame.origin.x + profileImageView.frame.width + 10, y: profileImageView.frame.origin.y, width: frame.width*0.75, height: 20))
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor(red: 68/255, green: 108/255, blue: 179/255, alpha: 1.0)
        addSubview(nameLabel)
        
        commentLabel = UILabel(frame: CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y + nameLabel.frame.height + 50, width: frame.width*0.9, height: frame.height - 100))
        commentLabel.font = UIFont.systemFont(ofSize: 13)
        commentLabel.lineBreakMode = .byWordWrapping
        commentLabel.numberOfLines = 2
        commentLabel.textColor = .black
        addSubview(commentLabel)
        
        timeLabel = UILabel(frame: CGRect(x: commentLabel.frame.origin.x, y: commentLabel.frame.origin.y + commentLabel.frame.height, width: frame.width*0.75, height: 20))
        timeLabel.font = UIFont.systemFont(ofSize: 13)
        timeLabel.textColor = .lightGray
        addSubview(timeLabel)
        
        heartButton = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width*0.07, height: frame.width*0.07))
        heartButton.center = CGPoint(x: commentLabel.frame.origin.x + commentLabel.frame.width + 30, y: commentLabel.frame.origin.y + (commentLabel.frame.height/2))
        heartButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        heartButton.addTarget(self, action: #selector(likedComment), for: .touchUpInside)
        addSubview(heartButton)
    }
    
    func likedComment() {
        if isLiked == false {
            heartButton.setImage(#imageLiteral(resourceName: "heart_red"), for: .normal)
            isLiked = true
        } else {
            heartButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            isLiked = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
