//
//  MainNavigationController.swift
//  DemoAudible
//
//  Created by Nguyen Nam on 10/18/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class MainNavigationController:UINavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLoggedIn(){
            let homeViewController = HomeViewController()
            let viewC = UIViewController()
            viewControllers = [homeViewController,viewC]
        }
        else{
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    private func isLoggedIn() -> Bool{
        return UserDefaults.standard.getIsLoggedIn()
    }
    
    @objc private func showLoginController(){
        let loginController = LoginViewController()
        present(loginController, animated: true) { 
                // perhaps we'll do something here later
        }
    }
    
    
}
