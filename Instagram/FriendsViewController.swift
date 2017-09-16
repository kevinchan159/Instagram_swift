//
//  FriendsViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/15/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
        self.title = "Other Users"
        view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
