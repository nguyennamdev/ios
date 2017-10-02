//
//  CustomTabbarViewController.swift
//  NewFeedFacebook
//
//  Created by Nguyen Nam on 8/21/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class CustomTabbarViewController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let feedController = FeedCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: feedController)
        
        
        navigationController.navigationBar.topItem?.title = "News Feed"
        
        // tabbar
        navigationController.tabBarItem.image = UIImage(named: "newspaper")
        navigationController.title = "News Feed"
        
        // viewcontroller request friend
        let friendRequestsController = FriendRequestsController()
        let secondNavigationController = UINavigationController(rootViewController: friendRequestsController)
        
        secondNavigationController.title = "Friends"
        secondNavigationController.tabBarItem.image = UIImage(named: "friends")
        secondNavigationController.navigationBar.topItem?.title = "Friends Request"
        
        let messengeNavigationController = UINavigationController(rootViewController: UIViewController())
        messengeNavigationController.navigationBar.topItem?.title = "Messenger"
        messengeNavigationController.tabBarItem.image = UIImage(named: "messenge")
        messengeNavigationController.title = "Messenger"
        
        let notificationNavigationController = UINavigationController(rootViewController: UIViewController())
        notificationNavigationController.navigationBar.topItem?.title = "Notification"
        notificationNavigationController.tabBarItem.image = UIImage(named: "world")?.resizeImage(newSize: CGSize(width: 25, height: 25))
        notificationNavigationController.title = "Notification"
        
        let moreNavigationController = UINavigationController(rootViewController: UIViewController())
        moreNavigationController.navigationBar.topItem?.title = "More"
        moreNavigationController.title = "More"
        let moreIcon = UIImage(named: "more")
        moreNavigationController.tabBarItem.image = moreIcon
        viewControllers = [navigationController, secondNavigationController,messengeNavigationController,
        notificationNavigationController,moreNavigationController]
    }
}
