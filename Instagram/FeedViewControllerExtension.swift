//
//  FeedViewControllerExtension.swift
//  Instagram
//
//  Created by Kevin Chan on 9/14/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

extension FeedViewController {
    
   
    func setupViews() {
        
        newFriendsButton = UIButton()
        newFriendsButton.setImage(#imageLiteral(resourceName: "add_friend"), for: .normal)
        newFriendsButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        newFriendsButton.addTarget(self, action: #selector(viewFriends), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: newFriendsButton)
        
        takePictureButton = UIButton()
        takePictureButton.setImage(#imageLiteral(resourceName: "camera_logo"), for: .normal)
        takePictureButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        takePictureButton.addTarget(self, action: #selector(takePicture), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: takePictureButton)
        
        
        navigationImageView = UIImageView(image: UIImage(named: "instagram")?.withRenderingMode(.alwaysTemplate))
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 44))
        navigationImageView.frame = titleView.bounds
        navigationImageView.tintColor = UIColor.black
        navigationImageView.contentMode = .scaleAspectFill
        titleView.addSubview(navigationImageView)
        self.navigationItem.titleView = titleView
        
        newPostView = UIView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height*0.2))
        newPostView.backgroundColor = .white
        view.addSubview(newPostView)
        
        profilePictureButton = UIButton(frame: CGRect(x: 15, y: 0, width: newPostView.frame.height*0.6, height: newPostView.frame.height*0.6))
        //uncomment the following line!!!
        //        profilePictureButton.setImage(user.profileImage, for: .normal)
        profilePictureButton.setImage(#imageLiteral(resourceName: "default_profile_pic"), for: .normal)
        profilePictureButton.center = CGPoint(x: profilePictureButton.center.x, y: newPostView.frame.height/2)
        profilePictureButton.layer.cornerRadius = profilePictureButton.frame.width/2
        profilePictureButton.layer.masksToBounds = true
        profilePictureButton.addTarget(self, action: #selector(editProfilePicture), for: .touchUpInside)
        newPostView.addSubview(profilePictureButton)
        
        postTextView = UITextView(frame: CGRect(x: profilePictureButton.frame.origin.x + profilePictureButton.frame.width + 15, y: 10, width: view.frame.width - profilePictureButton.frame.origin.x - profilePictureButton.frame.width - 30, height: view.frame.height*0.12))
        postTextView.layer.cornerRadius = 9
        postTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 0)
        postTextView.layer.borderWidth = 1
        postTextView.layer.borderColor = UIColor.gray.cgColor
        newPostView.addSubview(postTextView)
        
        postButton = UIButton(frame: CGRect(x: postTextView.frame.origin.x, y: postTextView.frame.origin.y + postTextView.frame.height + 5, width: postTextView.frame.width, height: view.frame.height*0.05))
        postButton.setTitle("Post", for: .normal)
        postButton.setTitleColor(.black, for: .normal)
        postButton.layer.cornerRadius = 9
        postButton.layer.borderWidth = 1
        postButton.layer.borderColor = UIColor.gray.cgColor
        postButton.addTarget(self, action: #selector(makePost), for: .touchUpInside)
        newPostView.addSubview(postButton)
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .yellow
        view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: newPostView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    
    
}
