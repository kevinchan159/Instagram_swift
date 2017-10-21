//
//  SideBarHeaderView.swift
//  Instagram
//
//  Created by Kevin Chan on 10/21/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class SideBarHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
