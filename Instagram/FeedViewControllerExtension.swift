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
        profilePictureButton.setImage(user.profileImage, for: .normal)
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
        
        buttonRowView = UIView()
        buttonRowView.translatesAutoresizingMaskIntoConstraints = false
        buttonRowView.backgroundColor = .white
        view.addSubview(buttonRowView)
        
        buttonRowView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        buttonRowView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        buttonRowView.topAnchor.constraint(equalTo: newPostView.bottomAnchor).isActive = true
        buttonRowView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = UIColor.lightGray
        buttonRowView.addSubview(separatorView)
        
        separatorView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.topAnchor.constraint(equalTo: buttonRowView.topAnchor).isActive = true
        
        let separator2View = UIView()
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        separator2View.backgroundColor = UIColor.lightGray
        buttonRowView.addSubview(separator2View)
        
        separator2View.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        separator2View.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator2View.bottomAnchor.constraint(equalTo: buttonRowView.bottomAnchor).isActive = true

        
        
        feedButton = UIButton()
        feedButton.translatesAutoresizingMaskIntoConstraints = false
        let feedImage = UIImage(named: "list_icon")?.withRenderingMode(.alwaysTemplate)
        feedButton.setImage(feedImage, for: .normal)
        feedButton.tintColor = .blue
        feedButton.addTarget(self, action: #selector(showFeed), for: .touchUpInside)
        buttonRowView.addSubview(feedButton)
        
        feedButton.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width*0.25).isActive = true
        feedButton.centerYAnchor.constraint(equalTo: buttonRowView.topAnchor, constant: 25).isActive = true
        feedButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        feedButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        
        photosButton = UIButton()
        photosButton.translatesAutoresizingMaskIntoConstraints = false
        let photoImage = UIImage(named: "photoes")?.withRenderingMode(.alwaysTemplate)
        photosButton.setImage(photoImage, for: .normal)
        photosButton.tintColor = .lightGray
        photosButton.addTarget(self, action: #selector(showPhotos), for: .touchUpInside)
        buttonRowView.addSubview(photosButton)
        
        photosButton.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width*0.75).isActive = true
        photosButton.centerYAnchor.constraint(equalTo: feedButton.centerYAnchor).isActive = true
        photosButton.widthAnchor.constraint(equalTo: feedButton.widthAnchor).isActive = true
        photosButton.heightAnchor.constraint(equalTo: feedButton.heightAnchor).isActive = true
        
        
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: buttonRowView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        photoCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        photoCollectionView.backgroundColor = .white
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCellId")
        view.addSubview(photoCollectionView)
        
        photoCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        photoCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        photoCollectionView.topAnchor.constraint(equalTo: buttonRowView.bottomAnchor).isActive = true
        photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        photoCollectionView.alpha = 0
    }
    
    func showFeed() {
        if feedButton.tintColor == .blue {
            return
        } else {
            feedButton.tintColor = .blue
            photosButton.tintColor = .lightGray
            tableView.alpha = 1
            photoCollectionView.alpha = 0
        }
    }
    
    func showPhotos() {
        if photosButton.tintColor == .blue {
            return
        } else {
            photosButton.tintColor = .blue
            feedButton.tintColor = .lightGray
            tableView.alpha = 0
            photoCollectionView.alpha = 1
        }
    }
    
    
    
}
