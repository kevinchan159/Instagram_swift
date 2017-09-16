//
//  CustomPageViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/3/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var user: User!
    var cameraViewController: CameraViewController!
    var navigationFeedController: UINavigationController!
    var friendsViewController: FriendsViewController!
    var viewControllersArray: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        let feedViewController = FeedViewController()
        feedViewController.user = user
        feedViewController.customPageViewController = self
        navigationFeedController = UINavigationController(rootViewController: feedViewController)
        cameraViewController = CameraViewController()
        cameraViewController.feedViewController = feedViewController
        friendsViewController = FriendsViewController(style: .plain)
        let navigationFriendsController = UINavigationController(rootViewController: friendsViewController)
        viewControllersArray = [navigationFriendsController, navigationFeedController, cameraViewController]
        
        dataSource = self
        
        setViewControllers([viewControllersArray[1]], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var currentViewControllerIndex = viewControllersArray.index(of: viewController)
        if currentViewControllerIndex == 0 {
            return nil
        } else {
            currentViewControllerIndex = currentViewControllerIndex! - 1
        }
        return viewControllersArray[currentViewControllerIndex!]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currentViewControllerIndex = viewControllersArray.index(of: viewController)
        if currentViewControllerIndex == 2 {
            return nil
        } else {
            currentViewControllerIndex = currentViewControllerIndex! + 1
        }
        return viewControllersArray[currentViewControllerIndex!]
    }
    
}
