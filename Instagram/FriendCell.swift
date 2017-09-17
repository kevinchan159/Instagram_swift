//
//  FriendCell.swift
//  Instagram
//
//  Created by Kevin Chan on 9/16/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class FriendCell: UICollectionViewCell {
    
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var usernameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    
    func setupViews() {
        profileImageView = UIImageView(frame: CGRect(x: 3, y: 0, width: frame.width*0.6, height: frame.width*0.6))
        profileImageView.center = CGPoint(x: frame.width/2, y: profileImageView.center.y)
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.layer.masksToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        addSubview(profileImageView)
                
        nameLabel = UILabel(frame: CGRect(x: 0, y: profileImageView.frame.origin.y + profileImageView.frame.height + 5, width: frame.width*0.9, height: 25))
        nameLabel.center = CGPoint(x: frame.width/2, y: nameLabel.center.y)
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = .black
        addSubview(nameLabel)
        
        usernameLabel = UILabel(frame: CGRect(x: 0, y: nameLabel.frame.origin.y + nameLabel.frame.height + 5, width: frame.width*0.9, height: 25))
        usernameLabel.center = CGPoint(x: frame.width/2, y: usernameLabel.center.y)
        usernameLabel.textAlignment = .center
        usernameLabel.font = UIFont.systemFont(ofSize: 13)
        usernameLabel.textColor = .lightGray
        addSubview(usernameLabel)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
