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
    var postId: Int!
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var postTextLabel: UILabel!
    
    var likeButton: UIButton!
    var commentButton: UIButton!
    
    
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
        
        
        postTextLabel = UILabel()
        postTextLabel.translatesAutoresizingMaskIntoConstraints = false
        postTextLabel.textAlignment = .left
        postTextLabel.font = UIFont.systemFont(ofSize: 13)
        postTextLabel.lineBreakMode = .byWordWrapping
        postTextLabel.numberOfLines = 2
        postTextLabel.textColor = .gray
        addSubview(postTextLabel)
        
        postTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        postTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        postTextLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12).isActive = true
        postTextLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -98)
        
        likeButton = UIButton()
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.center = CGPoint(x: profileImageView.center.x, y: likeButton.center.y)
        let heartImage = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        likeButton.setImage(heartImage, for: .normal)
        likeButton.tintColor = .black
        likeButton.addTarget(self, action: #selector(likedPost), for: .touchUpInside)
        addSubview(likeButton)
        
        likeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: profileImageView.frame.origin.x + 10).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        commentButton = UIButton()
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        let commentImage = UIImage(named: "comment_icon")?.withRenderingMode(.alwaysTemplate)
        commentButton.setImage(commentImage, for: .normal)
        commentButton.tintColor = .black
        addSubview(commentButton)
        
        commentButton.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 12).isActive = true
        commentButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        commentButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func likedPost() {
        if likeButton.image(for: .normal) == #imageLiteral(resourceName: "heart") {
            likeButton.setImage(#imageLiteral(resourceName: "heart_red"), for: .normal)
        } else {
            likeButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
