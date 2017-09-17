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
    
    var id: Int?
    var userId: Int?
    var userName: String?
    var text: String?
    var time: String?
    var profileImage: UIImage?
    
    
    init(userId: Int?, userName: String?, text: String?, time: String?, profileImage: UIImage?) {
        self.userId = userId
        self.text = text
        self.time = time
        self.userName = userName
        self.profileImage = profileImage
    }
    
}

class Comment {
    
    var user: User?
    var text: String?
    var profileImage: UIImage?
    var time: String?
    
    init(user: User?, text: String?, profileImage: UIImage?, time: String?) {
        self.user = user
        self.text = text
        self.profileImage = profileImage
        self.time = time
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
    } else if correctedHour == 0 {
        correctedHour = correctedHour + 12
        return "\(correctedHour)" + time.substring(from: hourIndex) + " AM"
    } else {
        return "\(correctedHour)" + time.substring(from: hourIndex) + " AM"
    }
    
    
}
