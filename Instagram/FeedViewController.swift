//
//  FeedViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/2/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var user: User!
    var profileImage: UIImage!
    var navigationImageView: UIImageView!
    var newFriendsButton: UIButton!
    var takePictureButton: UIButton!
    
    var customPageViewController: CustomPageViewController!
    
    var newPostView: UIView!
    var profilePictureButton: UIButton!
    var postTextView: UITextView!
    var postButton: UIButton!
    
    var tableView: UITableView!
    var postsArray: [Post] = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        profileImage = UIImage(named: "default_profile_pic")
        
        setupViews()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "postCellId")
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCellId") as! PostCell
        let post = postsArray[indexPath.row]
        cell.userId = post.userId
        cell.profileImageView.image = user.profileImage
        cell.nameLabel.text = user.name
        cell.timeLabel.text = post.time
        cell.postTextLabel.text = post.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = postsArray[indexPath.row].text
        let frameForText = NSString(string: text!).boundingRect(with: CGSize(width: view.frame.width*0.9, height: 2000) , options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
        let height = frameForText.height + 20 + 70
        return height
    }
    
    
    func makePost() {
        if (postTextView.text == "") {
            return
        }
        let date = NSDate() as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let time = dateFormatter.string(from: date)
        let post = Post(userId: user.id, text: postTextView.text, time: time)
        postsArray.insert(post, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
        postTextView.text = ""
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
    
    func viewFriends() {
        print("view friends")
    }
}
