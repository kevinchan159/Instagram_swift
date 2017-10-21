//
//  ThirdMainViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 10/21/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class ThirdMainViewController: SWRevealViewController {
    
    var sideBarButton: UIButton!
    
    override func viewDidLoad() {
        // This is what gets called when the view controller is shown
        // for the first time
        
        self.setRear(SideBarViewController(), animated: true)
        
        sideBarButton = UIButton()
        sideBarButton.setImage(UIImage(named: "chase"), for: .normal)
        sideBarButton.contentMode = .scaleAspectFit
        sideBarButton.frame = CGRect(x: 12, y: 40, width: 31, height: 31)
        sideBarButton.addTarget(self, action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addSubview(sideBarButton)
        
        view.backgroundColor = .white
        
    }
    
}
