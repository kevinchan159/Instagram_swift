//
//  SideBarCell.swift
//  Instagram
//
//  Created by Kevin Chan on 10/21/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class SideBarCell: UITableViewCell {
    
    var nameLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = UILabel(frame: CGRect(x: 12, y: 0, width: frame.width*0.5, height: frame.height*0.75))
        nameLabel.center = CGPoint(x: (nameLabel?.center.x)!, y: frame.height/2)
        addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
