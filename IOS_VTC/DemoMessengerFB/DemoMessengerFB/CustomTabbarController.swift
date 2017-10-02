//
//  CustomTabbarController.swift
//  DemoMessengerFB
//
//  Created by Nguyen Nam on 9/20/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class CustomTabbarController:UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let friendsNavigationController = UINavigationController(rootViewController: friendsController)
        friendsNavigationController.tabBarItem.title = "Recent"
        friendsNavigationController.tabBarItem.image  = #imageLiteral(resourceName: "comment")
        
        viewControllers = [friendsNavigationController,createDummyNavControllerWithText(text: "Calls", image: "more")]
        
        
    }
    
    private func createDummyNavControllerWithText(text:String,image:String) -> UINavigationController{
        let viewController = UIViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem.title = text
        navigation.tabBarItem.image = UIImage(named: image)
        return navigation
    }
    
    
}
