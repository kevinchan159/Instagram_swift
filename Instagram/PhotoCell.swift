//
//  PhotoCell.swift
//  Instagram
//
//  Created by Kevin Chan on 9/15/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 1).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -1).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 1).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
