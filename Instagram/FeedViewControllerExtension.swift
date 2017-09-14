//
//  FeedViewControllerExtension.swift
//  Instagram
//
//  Created by Kevin Chan on 9/14/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

extension FeedViewController {
    
//    var newPostView: UIView!
//    var postTextArea: UITextView!
//    var postButton: UIButton!
   
    func setupViews() {
        
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
        newPostView.backgroundColor = .gray
        view.addSubview(newPostView)
        
        profilePictureButton = UIButton(frame: CGRect(x: 15, y: 0, width: newPostView.frame.height*0.6, height: newPostView.frame.height*0.6))
        //uncomment the following line!!!
        //        profilePictureButton.setImage(user.profileImage, for: .normal)
        profilePictureButton.setImage(#imageLiteral(resourceName: "default_profile_pic"), for: .normal)
        profilePictureButton.backgroundColor = .yellow
        profilePictureButton.center = CGPoint(x: profilePictureButton.center.x, y: newPostView.frame.height/2)
        profilePictureButton.layer.cornerRadius = profilePictureButton.frame.width/2
        profilePictureButton.layer.masksToBounds = true
        profilePictureButton.addTarget(self, action: #selector(editProfilePicture), for: .touchUpInside)
        newPostView.addSubview(profilePictureButton)
        
        postTextView = UITextView(frame: CGRect(x: profilePictureButton.frame.origin.x + profilePictureButton.frame.width + 15, y: 10, width: view.frame.width - profilePictureButton.frame.origin.x - profilePictureButton.frame.width - 30, height: view.frame.height*0.12))
        postTextView.layer.cornerRadius = 9
        newPostView.addSubview(postTextView)
    }
    
    
    
    
}
