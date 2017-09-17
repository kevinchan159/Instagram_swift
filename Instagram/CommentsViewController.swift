//
//  CommentsViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/16/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit
import Alamofire

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var postView: UIView!
    
    var user: User!
    var postId: Int!
    var postUserId: Int!
    var profileImage: UIImage!
    var name: String!
    var timeString: String!
    var postText: String!
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var postTextLabel: UILabel!
    
    var commentsTableView: UITableView!
    var commentsArray: [Comment] = [Comment]()
    
    var newCommentView: UIView!
    var bottomConstraint: NSLayoutConstraint!
    var airplaneImageView: UIImageView!
    var commentTextField: UITextField!
    var postButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Comments"
        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: view.window)
        
//        commentsArray.append(Comment(user: user, text: "First comment", profileImage: user.profileImage, time: "10:02 PM"))
//        commentsArray.append(Comment(user: user, text: "This is going to be a really long string that goes over one line. Abcdefgh ijklmnop qrs", profileImage: user.profileImage, time: "10:05 PM"))
        
        setupViews()
        fillUpCommentsArray()
        print(commentsArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "commentCellId") as! CommentCell
        let comment = commentsArray[indexPath.row]
        print(comment.text)
        if let text = comment.text {
           cell.commentLabel.text = text
        }
        cell.nameLabel.text = comment.user?.name
        cell.profileImageView.image = comment.user?.profileImage
        cell.timeLabel.text = comment.time
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = commentsArray[indexPath.row].text
        let frameForText = NSString(string: text!).boundingRect(with: CGSize(width: view.frame.width*0.9, height: 2000) , options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)], context: nil)
        let height = frameForText.height + 10 + 80
        return height
    }
    
    func makePost() {
        if commentTextField.text == "" {
            return
        }
        guard let text = commentTextField.text else {
            return
        }
        let date = NSDate() as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let time = dateFormatter.string(from: date)
        let comment = Comment(user: user, text: text, profileImage: user.profileImage, time: time)
        commentsArray.append(comment)
        let indexPath = IndexPath(row: commentsArray.count - 1, section: 0)
        commentsTableView.insertRows(at: [indexPath], with: .fade)
        commentTextField.text = ""
        let parameters = [
            "post_id": postId,
            "user_id": user.id,
            "text": text
        ] as [String : Any]
        Alamofire.request("http://localhost:3000/comment", method: .post, parameters: parameters)
    }
    
    
    func fillUpCommentsArray() {
        let parameters = [
            "post_id": postId
        ]
        Alamofire.request("http://localhost:3000/comments", method: .post, parameters: parameters).responseJSON { (response) in
            //print(response)
            if let JSON = response.result.value as? [[String:Any]] {
                print(JSON)
                if (JSON.count == 0) {
                    return
                }
                for i in (0...JSON.count-1) {
                    let dict = JSON[i]
                    let text = dict["text"] as? String
                    let created_at = dict["created_at"] as! String
                    let startIndex = created_at.index(created_at.startIndex, offsetBy: 11)
                    let endIndex = created_at.index(created_at.startIndex, offsetBy: 16)
                    let timeString = created_at.substring(with: Range<String.Index>(uncheckedBounds: (lower: startIndex, upper: endIndex)))
                    let parsedTime = parseTime(time: timeString)
                    let user_id = dict["user_id"] as? Int
                    
                    
                    let parameters2 = [
                        "user_id": user_id
                    ]
                    Alamofire.request("http://localhost:3000/user", method: .post, parameters: parameters2).responseJSON(completionHandler: { (response) in
                        if let JSON2 = response.result.value as? [[String:Any]] {
                            print (JSON2)
                            let userInfo = JSON2[0]
                            let profileImageURLString = userInfo["profile_image"] as! String
                            if profileImageURLString == "default" {
                                let userProfileImage = #imageLiteral(resourceName: "default_profile_pic")
                                let user = User(id: user_id, name: userInfo["name"] as? String, username: userInfo["username"] as? String, profileImage: userProfileImage)
                                let newComment = Comment(user: user, text: text, profileImage: userProfileImage, time: parsedTime)
                                DispatchQueue.main.async {
                                    print(newComment)
                                    self.commentsArray.insert(newComment, at: 0)
                                    let indexPath = IndexPath(row: 0, section: 0)
                                    self.commentsTableView.insertRows(at: [indexPath], with: .left)
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
                                    let userProfileImage = UIImage(data: data!)
                                    let user = User(id: user_id, name: userInfo["name"] as? String, username: userInfo["username"] as? String, profileImage: userProfileImage)
                                    let newComment = Comment(user: user, text: text, profileImage: userProfileImage, time: parsedTime)
                                    DispatchQueue.main.async {
                                        print(newComment)
                                        self.commentsArray.insert(newComment, at: 0)
                                        let indexPath = IndexPath(row: 0, section: 0)
                                        self.commentsTableView.insertRows(at: [indexPath], with: .left)
                                    }
                                    
                                }).resume()
                            }
                        }
                    })
                    
                }
            }
        }
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint.constant = -keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint.constant = 0
        }
    }
    
    
    
    
    
    
    
    
    
    
}
