//
//  CustomTabbarController.swift
//  DemoChat
//
//  Created by Nguyen Nam on 10/3/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import SocketIO

class CustomTabbarController: UITabBarController {
    
    var user:User?
    var friends:[Friend]?
    
    var messageController:MessageCollectionController?
    
    override func viewDidLoad() {
        print("custom did load")
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("custom did appear")
        navigationItem.hidesBackButton = true
        //        navigationItem.title = name
        
        messageController = MessageCollectionController()
        let messageTabbarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), tag:0)
        messageController?.tabBarItem = messageTabbarItem
        messageController?.user = self.user
        messageController?.friends = self.friends
        
        let callController = UIViewController()
        let callNavigation = UINavigationController(rootViewController: callController)
        callNavigation.tabBarItem.image = #imageLiteral(resourceName: "call")
        callNavigation.title = "Call"
        
        let groupController = UIViewController()
        let groupNavigation = UINavigationController(rootViewController: groupController)
        groupNavigation.tabBarItem.image = #imageLiteral(resourceName: "group")
        groupNavigation.title = "Group"
        
        let contactController = UIViewController()
        let contactNavigation = UINavigationController(rootViewController: contactController)
        contactNavigation.tabBarItem.image = #imageLiteral(resourceName: "contact")
        contactNavigation.title = "Contact"
        
        viewControllers = [messageController!,callNavigation,groupNavigation,contactNavigation]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("custom will appear")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("custom will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("custom did disappear")
    }
    
}
