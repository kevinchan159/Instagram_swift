//
//  FriendsViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/15/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit
import Alamofire

class FriendsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user: User! {
        didSet {
            fillUsersArray()
        }
    }
    var usersArray: [User] = [User]()
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        
        self.title = "Other Users"
        view.backgroundColor = .white
        
        collectionView?.register(FriendCell.self, forCellWithReuseIdentifier: "friendCellId")
        //collectionView?.frame = CGRect(x: 0, y: 32, width: view.frame.width, height: view.frame.height-64)
        collectionView?.backgroundColor = .white
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendCellId", for: indexPath) as! FriendCell
        let user = usersArray[indexPath.row]
        cell.nameLabel.text = user.name
        cell.usernameLabel.text = user.username
        cell.profileImageView.image = user.profileImage
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width*0.47, height: 200)
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
                            self.usersArray.insert(user, at: 0)
//                            let indexPath = IndexPath(item: 0, section: 0)
//                            self.collectionView?.insertItems(at: [indexPath])
                            self.collectionView?.reloadData()
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
                                self.usersArray.insert(user, at: 0)
//                                let indexPath = IndexPath(item: 0, section: 0)
//                                self.collectionView?.insertItems(at: [indexPath])
                                self.collectionView?.reloadData()
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
