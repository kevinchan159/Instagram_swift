//
//  FeedViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/2/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit
import Alamofire

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
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
    
    var buttonRowView: UIView!
    var feedButton: UIButton!
    var photosButton: UIButton!
    
    var tableView: UITableView!
    var postsArray: [Post] = [Post]()
    
    var photoCollectionView: UICollectionView!
    var photoArray: [UIImage] = [UIImage]()
    
    var idToProfileImage: [Int:UIImage] = [Int:UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        profileImage = UIImage(named: "default_profile_pic")
        
        fillPostsArray { 
            self.tableView.reloadData()
        }
        setupViews()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "postCellId")
                
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCellId") as! PostCell
        let post = postsArray[indexPath.row]
        cell.userId = post.userId
        cell.profileImageView.image = post.profileImage
        cell.nameLabel.text = post.userName
        cell.timeLabel.text = post.time
        cell.postTextLabel.text = post.text
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = postsArray[indexPath.row].text
        let frameForText = NSString(string: text!).boundingRect(with: CGSize(width: view.frame.width*0.9, height: 2000) , options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)], context: nil)
        let height = frameForText.height + 10 + 98
        return height
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postCell = tableView.cellForRow(at: indexPath) as! PostCell
        let commentsViewController = CommentsViewController()
        commentsViewController.user = user
        commentsViewController.postUserId = postCell.userId
        commentsViewController.profileImage = postCell.profileImageView.image
        commentsViewController.name = postCell.nameLabel.text
        commentsViewController.timeString = postCell.timeLabel.text
        commentsViewController.postText = postCell.postTextLabel.text
        self.navigationController?.pushViewController(commentsViewController, animated: true)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCellId", for: indexPath) as! PhotoCell
        cell.imageView.image = photoArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width*0.315, height: view.frame.width*0.315)
    }
    
    
    
    
    func makePost() {
        if (postTextView.text == "") {
            return
        }
        let date = NSDate() as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let time = dateFormatter.string(from: date)
        let post = Post(userId: user.id, userName: user.name, text: postTextView.text, time: time, profileImage: user.profileImage)
        postsArray.insert(post, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
        let parameters = [
            "user_id": user.id,
            "username": user.name as! String,
            "text": postTextView.text
        ] as [String : Any]
        postTextView.text = ""
        Alamofire.request("http://localhost:3000/posts", method: .post, parameters: parameters)
    }
    
    func editProfilePicture() {
        print("edit profile picture")
        let profileImageViewController = ProfileImageViewController()
        profileImageViewController.profileImage = user.profileImage
        profileImageViewController.feedViewController = self
        profileImageViewController.user = user
        navigationController?.pushViewController(profileImageViewController, animated: true)
    }
    
    func takePicture() {
        customPageViewController.setViewControllers([customPageViewController.viewControllersArray[2]], direction: .forward, animated: true, completion: nil)
    }
    
    func viewFriends() {
//        for i in 0...postsArray.count-1 {
//            print(postsArray[i].text)
//        }
        customPageViewController.setViewControllers([customPageViewController.viewControllersArray[0]], direction: .reverse, animated: true, completion: nil)
    }
    
    func fillPostsArray(completion: @escaping () -> ()) {
        Alamofire.request("http://localhost:3000/posts", method: .get, parameters: nil).responseJSON { (response) in
            print(response)
            if let JSON = response.result.value as? [[String: Any]] {
                // print(JSON)
                for i in 0...(JSON.count - 1) {
                    //print(JSON[i]["id"])
                    let post = JSON[i]
                    let created_at = post["created_at"] as! String
                    let startIndex = created_at.index(created_at.startIndex, offsetBy: 11)
                    let endIndex = created_at.index(created_at.startIndex, offsetBy: 16)
                    let timeString = created_at.substring(with: Range<String.Index>(uncheckedBounds: (lower: startIndex, upper: endIndex)))
                    let parsedTime = self.parseTime(time: timeString)
                    var userProfileImage: UIImage!
//                    if let image = self.idToProfileImage[(post["user_id"] as? Int)!] {
//                        userProfileImage = image
                    //                        let newPost = Post(userId: post["user_id"] as? Int, userName: post["username"] as! String, text: post["text"] as! String, time: parsedTime, profileImage: userProfileImage)
                    //                        DispatchQueue.main.async {
                    //                            self.postsArray.insert(newPost, at: 0)
                    //                            //                                let indexPath = IndexPath(row: 0, section: 0)
                    //                            //                                self.tableView.insertRows(at: [indexPath], with: .left)
                    //                            self.tableView.reloadData()
                    //                        }
                    //                    } else {
                    let parameters = [
                        "user_id": post["user_id"]
                    ]
                    Alamofire.request("http://localhost:3000/users_image", method: .post, parameters: parameters).responseJSON(completionHandler: { (response) in
                        if let JSON2 = response.result.value as? [String:Any] {
                            //print (JSON2)
                            let profileImageURLString = JSON2["profile_image"] as! String
                            if profileImageURLString == "default" {
                                userProfileImage = #imageLiteral(resourceName: "default_profile_pic")
                                let newPost = Post(userId: post["user_id"] as? Int, userName: post["username"] as! String, text: post["text"] as! String, time: parsedTime, profileImage: userProfileImage)
                                self.idToProfileImage[post["user_id"] as! Int] = userProfileImage
                                DispatchQueue.main.async {
                                    self.postsArray.insert(newPost, at: 0)
                                    let indexPath = IndexPath(row: 0, section: 0)
                                    self.tableView.insertRows(at: [indexPath], with: .left)
                                    //self.tableView.reloadData()
                                }
                            } else {
                                let url = URL(string: profileImageURLString)
                                let urlRequest = URLRequest(url: url!)
                                URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, err) in
                                    print("in url session")
                                    if (err != nil) {
                                        print (err)
                                        return
                                    }
                                    userProfileImage = UIImage(data: data!)
                                    let newPost = Post(userId: post["user_id"] as? Int, userName: post["username"] as! String, text: post["text"] as! String, time: parsedTime, profileImage: userProfileImage)
                                    self.idToProfileImage[post["user_id"] as! Int] = userProfileImage
                                    DispatchQueue.main.async {
                                        //print(newPost.text)
                                        self.postsArray.insert(newPost, at: 0)
                                        let indexPath = IndexPath(row: 0, section: 0)
                                        self.tableView.insertRows(at: [indexPath], with: .left)
                                    }
                                    
                                    
                                }).resume()
                            }
                        }
                    })
                }
                
                
            }
        }
        
    }
    
    
    // Converts time from created_at column to time like "10:30 PM"
    func parseTime(time: String) -> String {
        let hourIndex = time.index(time.startIndex, offsetBy: 2)
        let hour: Int = Int(time.substring(to: hourIndex))!
        var correctedHour = (hour + 20) % 24
        if correctedHour > 12 {
            correctedHour = correctedHour - 12
            return "\(correctedHour)" + time.substring(from: hourIndex) + " PM"
        } else if correctedHour == 12 {
            return "\(correctedHour)" + time.substring(from: hourIndex) + " PM"
        } else {
            return "\(correctedHour)" + time.substring(from: hourIndex) + " AM"
        }
        
        
    }
}
