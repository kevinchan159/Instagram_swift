//
//  ProfileImageViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/10/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseStorage

class ProfileImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var feedViewController: FeedViewController!
    
    var profileImage: UIImage!
    var profileImageView: UIImageView!
    var choosePictureButton: UIButton!
    var user: User!
    
    override func viewDidLoad() {
        
        self.title = "Profile Picture"
        view.backgroundColor = .white
        
        profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.6, height: view.frame.width*0.6))
        profileImageView.center = CGPoint(x: view.frame.width/2, y: view.frame.height*0.3)
        profileImageView.image = profileImage
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.layer.masksToBounds = true
        view.addSubview(profileImageView)
        
        choosePictureButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.6, height: view.frame.height*0.08))
        choosePictureButton.center = CGPoint(x: view.frame.width/2, y: view.frame.height*0.65)
        choosePictureButton.setTitle("Choose Picture", for: .normal)
        choosePictureButton.setTitleColor(.black, for: .normal)
        choosePictureButton.backgroundColor = .white
        choosePictureButton.layer.cornerRadius = 5
        choosePictureButton.layer.borderColor = UIColor.black.cgColor
        choosePictureButton.layer.borderWidth = 2
        choosePictureButton.addTarget(self, action: #selector(choosePicture), for: .touchUpInside)
        view.addSubview(choosePictureButton)
        
        
    }
    
    func choosePicture() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImageView.image = image
            profileImage = image
        } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.image = image
            profileImage = image
        } else {
            print("photo selection failed")
            return
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        feedViewController.profilePictureButton.setImage(profileImage, for: .normal)
        feedViewController.profileImage = profileImage
        feedViewController.user.profileImage = profileImage
        feedViewController.tableView.reloadData()
        
        var imageURLString = ""
        
        if let imageData = UIImagePNGRepresentation(profileImage) {
            let savedImageName = UUID().uuidString
            let storageRef = Storage.storage().reference().child("\(savedImageName).png")
            storageRef.putData(imageData, metadata: nil, completion: { (metadata, err) in
                if (err != nil) {
                    print(err)
                    return
                }
                
                if let urlString = metadata?.downloadURL()?.absoluteString {
                    imageURLString = urlString
                }
                
                let parameters = [
                    "userId": self.user.id,
                    "profile_image": imageURLString
                ] as [String : Any]
                
                Alamofire.request("http://localhost:3000/users", method: .put, parameters: parameters).responseJSON { (response) in
                    print("uploaded image")
                }
            })
            
        }
    }
    
}
