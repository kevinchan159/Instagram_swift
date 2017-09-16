//
//  FriendsViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/15/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit
import Alamofire

class FriendsViewController: UITableViewController {
    
    var user: User! {
        didSet {
            fillUsersArray()
        }
    }
    var usersArray: [User] = [User]()
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
        self.title = "Other Users"
        view.backgroundColor = .white
        
        tableView.register(FriendCell.self, forCellReuseIdentifier: "friendCellId")
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCellId") as! FriendCell
        let user = usersArray[indexPath.row]
        cell.nameLabel.text = user.name
        cell.usernameLabel.text = user.username
        cell.profileImageView.image = user.profileImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func fillUsersArray() {
        let parameters = [
            "user_id": user.id
        ]
        Alamofire.request("http://localhost:3000/users", method: .post, parameters: parameters).responseJSON { (response) in
            if let JSON = response.result.value as? [[String:Any]] {
                print("USERS")
                print(JSON)
                for i in 0...(JSON.count - 1) {
                    let userInfo = JSON[i]
                    let id = userInfo["id"] as? Int
                    let name = userInfo["name"] as? String
                    let username = userInfo["username"] as? String
                    let profileImageString = userInfo["profile_image"] as? String
                    if profileImageString == "default" {
                        let user = User(id: id, name: name, username: username, profileImage: #imageLiteral(resourceName: "default_profile_pic"))
                        DispatchQueue.main.async {
                            self.usersArray.append(user)
                            let indexPath = IndexPath(row: self.usersArray.count, section: 0)
                            self.tableView.insertRows(at: [indexPath], with: .left)
                        }
                    } else {
                        let url = URL(string: profileImageString!)
                        let urlRequest = URLRequest(url: url!)
                        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, err) in
                            if (err != nil) {
                                print (err)
                                return
                            }
                            let image = UIImage(data: data!)
                            let user = User(id: id, name: name, username: username, profileImage: image)
                            DispatchQueue.main.async {
                                self.usersArray.append(user)
                                let indexPath = IndexPath(row: self.usersArray.count, section: 0)
                                self.tableView.insertRows(at: [indexPath], with: .left)
                            }
                        }).resume()
                    }
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
