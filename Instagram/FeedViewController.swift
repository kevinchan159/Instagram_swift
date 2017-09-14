//
//  FeedViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/2/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    
    var user: User!
    var profileImage: UIImage!
    var navigationImageView: UIImageView!
    var profilePictureButton: UIButton!
    var takePictureButton: UIButton!
    
    var customPageViewController: CustomPageViewController!
    
    var newPostView: UIView!
    var postTextView: UITextView!
    var postButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        profileImage = UIImage(named: "default_profile_pic")
        
        setupViews()
        
    }
    
    func editProfilePicture() {
        print("edit profile picture")
        let profileImageViewController = ProfileImageViewController()
        profileImageViewController.profileImage = profileImage
        profileImageViewController.feedViewController = self
        navigationController?.pushViewController(profileImageViewController, animated: true)
    }
    
    func takePicture() {
        //print("take picture")
        customPageViewController.setViewControllers([customPageViewController.viewControllersArray[1]], direction: .forward, animated: true, completion: nil)
    }
}
