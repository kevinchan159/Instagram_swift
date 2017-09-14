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
    var viewControllersArray: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        cameraViewController = CameraViewController()
        let feedViewController = FeedViewController()
        feedViewController.user = user
        feedViewController.customPageViewController = self
        navigationFeedController = UINavigationController(rootViewController: feedViewController)
        viewControllersArray = [navigationFeedController, cameraViewController]
        
        dataSource = self
        
        setViewControllers([viewControllersArray[0]], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var currentViewControllerIndex = viewControllersArray.index(of: viewController)
        if currentViewControllerIndex == 0 {
            return nil
        } else {
            currentViewControllerIndex = 0
        }
        return viewControllersArray[currentViewControllerIndex!]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currentViewControllerIndex = viewControllersArray.index(of: viewController)
        if currentViewControllerIndex == 0 {
            currentViewControllerIndex = 1
        } else {
            return nil
        }
        return viewControllersArray[currentViewControllerIndex!]
    }
    
}
