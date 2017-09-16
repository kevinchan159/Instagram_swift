//
//  CommentsViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/16/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    var postView: UIView!
    
    var userId: Int!
    var profileImage: UIImage!
    var name: String!
    var timeString: String!
    var postText: String!
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var postTextLabel: UILabel!
    
    var commentsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Comments"
        view.backgroundColor = .white
        
        postView = UIView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height*0.2))
        postView.backgroundColor = .white
        view.addSubview(postView)
        
        profileImageView = UIImageView(frame: CGRect(x: 24, y: 24, width: 50, height: 50))
        profileImageView.image = profileImage
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.layer.masksToBounds = true
        postView.addSubview(profileImageView)
        
        nameLabel = UILabel(frame: CGRect(x: profileImageView.frame.origin.x + profileImageView.frame.width + 10, y: profileImageView.frame.origin.y, width: view.frame.width*0.75, height: 25))
        nameLabel.text = name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textAlignment = .left
        postView.addSubview(nameLabel)
        
        timeLabel = UILabel(frame: CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y + nameLabel.frame.height, width: nameLabel.frame.width, height: nameLabel.frame.height))
        timeLabel.text = timeString
        timeLabel.font = UIFont.systemFont(ofSize: 13)
        timeLabel.textAlignment = .left
        postView.addSubview(timeLabel)
        
        
        postTextLabel = UILabel()
        postTextLabel.translatesAutoresizingMaskIntoConstraints = false
        postTextLabel.text = postText
        postTextLabel.textAlignment = .left
        postTextLabel.font = UIFont.systemFont(ofSize: 13)
        postTextLabel.lineBreakMode = .byWordWrapping
        postTextLabel.numberOfLines = 2
        postTextLabel.textColor = .gray
        postView.addSubview(postTextLabel)
        
        postTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        postTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        postTextLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12).isActive = true
        postTextLabel.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -98)
        
        commentsTableView = UITableView(frame: CGRect(x: 0, y: postView.frame.origin.y + postView.frame.height, width: view.frame.width, height: view.frame.height - postView.frame.origin.y - postView.frame.height))
        commentsTableView.backgroundColor = .green
        view.addSubview(commentsTableView)
        
    }
    
}
