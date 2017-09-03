//
//  FeedViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/2/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    var navigationImageView: UIImageView!
    var profilePictureButton: UIButton!
    var takePictureButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    
        profilePictureButton = UIButton()
        profilePictureButton.setImage(#imageLiteral(resourceName: "default_profile_pic"), for: .normal)
        profilePictureButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        profilePictureButton.layer.cornerRadius = profilePictureButton.frame.width/2
        profilePictureButton.layer.masksToBounds = true
        profilePictureButton.addTarget(self, action: #selector(editProfilePicture), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profilePictureButton)
        
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
        
    }
    
    func editProfilePicture() {
        print("edit profile picture")
    }
    
    func takePicture() {
        print("take picture")
    }
}
