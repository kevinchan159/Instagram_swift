//
//  CommentsViewControllerExtension.swift
//  Instagram
//
//  Created by Kevin Chan on 9/17/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

extension CommentsViewController {
    
    func setupViews() {
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
        
        
        let separatorView = UIView(frame: CGRect(x: 12, y: postView.frame.origin.y + postView.frame.height-1, width: view.frame.width-24, height: 1))
        separatorView.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
        view.addSubview(separatorView)
        
        commentsTableView = UITableView(frame: CGRect(x: 0, y: postView.frame.origin.y + postView.frame.height, width: view.frame.width, height: view.frame.height - postView.frame.origin.y - postView.frame.height - 64))
        commentsTableView.separatorColor = .white
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.register(CommentCell.self, forCellReuseIdentifier: "commentCellId")
        view.addSubview(commentsTableView)
        
        
        newCommentView = UIView()
        newCommentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newCommentView)
        view.bringSubview(toFront: newCommentView)
        
        bottomConstraint = NSLayoutConstraint(item: newCommentView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint)
        newCommentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        newCommentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        newCommentView.backgroundColor = .white
        newCommentView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        
        airplaneImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        airplaneImageView.center = CGPoint(x: view.frame.width*0.05, y: 32)
        airplaneImageView.image = UIImage(named: "airplane")?.withRenderingMode(.alwaysTemplate)
        airplaneImageView.tintColor = .lightGray
        airplaneImageView.backgroundColor = .white
        newCommentView.addSubview(airplaneImageView)
        
        commentTextField = UITextField(frame: CGRect(x: view.frame.width*0.1, y: 0, width: view.frame.width*0.75, height: 64))
        commentTextField.placeholder = "Add new comment"
        commentTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        commentTextField.autocorrectionType = .no
        commentTextField.backgroundColor = .white
        newCommentView.addSubview(commentTextField)
        
        postButton = UIButton(frame: CGRect(x: commentTextField.frame.origin.x + commentTextField.frame.width, y: 0, width: view.frame.width*0.15, height: 64))
        postButton.setTitle("Post", for: .normal)
        postButton.setTitleColor(UIColor(red: 25/255, green: 181/255, blue: 254/255, alpha: 1.0), for: .normal)
        postButton.addTarget(self, action: #selector(makePost), for: .touchUpInside)
        postButton.backgroundColor = .white
        newCommentView.addSubview(postButton)
        
        let separatorView2 = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1))
        separatorView.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
        newCommentView.addSubview(separatorView2)
        newCommentView.bringSubview(toFront: separatorView2)
    }
    
}
