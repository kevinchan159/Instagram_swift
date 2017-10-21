//
//  SideBarViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 10/21/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class SideBarViewController: UITableViewController {
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        tableView.register(SideBarCell.self, forCellReuseIdentifier: "sideBarCell")
        tableView.register(SideBarHeaderView.self, forHeaderFooterViewReuseIdentifier: "sideBarHeader")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideBarCell") as! SideBarCell
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "Cell 1"
        case 1:
            cell.nameLabel.text = "Cell 2"
        case 2:
            cell.nameLabel.text = "Cell 3"
        default:
            cell.nameLabel.text = ""
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController = self.revealViewController()
        switch indexPath.row {
        case 0:
            revealViewController?.pushFrontViewController(MainViewController(), animated: true)
        case 1:
            revealViewController?.pushFrontViewController(SecondMainViewController(), animated: true)
        case 2:
            revealViewController?.pushFrontViewController(ThirdMainViewController(), animated: true)
        default:
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sideBarHeader") as! SideBarHeaderView!
        headerView?.backgroundColor = .white
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
}
