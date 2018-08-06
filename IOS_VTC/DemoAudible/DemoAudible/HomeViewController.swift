//
//  HomeViewController.swift
//  DemoAudible
//
//  Created by Nguyen Nam on 10/18/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class HomeViewController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(handlerSignOut))
    }
    
    func handlerSignOut(){
        UserDefaults.standard.setIsLoggedIn(value: false)
        present(LoginViewController(), animated: true, completion: nil)
    }
}
