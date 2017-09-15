//
//  Models.swift
//  Instagram
//
//  Created by Kevin Chan on 9/11/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class User {
    
    var id: Int?
    var name: String?
    var username: String?
    var profileImage: UIImage?
    
    init(id: Int?, name: String?, username: String?, profileImage: UIImage?) {
        self.id = id
        self.name = name
        self.username = username
        self.profileImage = profileImage
    }
    
}

class Post {
    
    var userId: Int?
    var text: String?
    var time: String?
    
    init(userId: Int?, text: String?, time: String?) {
        self.userId = userId
        self.text = text
        self.time = time
    }
    
}