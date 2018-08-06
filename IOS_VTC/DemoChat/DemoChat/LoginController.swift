//
//  LoginController.swift
//  DemoChat
//
//  Created by Nguyen Nam on 10/3/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import CoreData

class LoginViewController: UIViewController ,FBSDKLoginButtonDelegate {
    
    var context:NSManagedObjectContext?
    
    
    let loginButton:FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["public_profile", "email","user_friends"]
        return button
    }()
    
    let socketio:SocketIOManager = SocketIOManager.getIntance()
    
    
    var friends:[Friend]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("login did load")
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        context = appdelegate?.persistentContainer.viewContext
        
        view.backgroundColor = UIColor.white
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        
        socketio.clientConnected()
        if (FBSDKAccessToken.current()) != nil{
            // fetch user current
            self.fetchProfile()
        }
        socketio.connect()
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        fetchProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("did log out")
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func fetchProfile(){
        let prameters = ["fields" : "email , first_name , last_name, picture.type(large)"]
        FBSDKGrfaphRequest(graphPath: "me", parameters: prameters).start { (connect, result, error) in
            if error != nil{
                return
            }
            let data = result as? [String:AnyObject]
            guard
                let id = data?["id"] as? String,
                let email = data?["email"] as? String,
                let first_name = data?["first_name"] as? String,
                let last_name = data?["last_name"] as? String,
                let picture = data?["picture"] as? [String:AnyObject],
                let urlData = picture["data"] as? [String:AnyObject],
                let url = urlData["url"] as? String
                else{
                    return
            }
            let user:User = User(context: self.context!)
            user.email = email
            user.isActive = true
            user.name = "\(first_name) \(last_name)"
            user.profileImageUrl = url
            user.id = id
            
            self.socketio.sendInforUser(data:data!)
            
            self.socketio.getListUser(completionHander: { (friends) in
                self.friends = friends
                user.friends = NSSet(array: self.friends!)
                self.navigationToCustomTabbarController(user: user, friends: self.friends!)
            })
        }
    }
    
    func navigationToCustomTabbarController(user:User, friends:[Friend]){
//        let customTabbarController = CustomTabbarController()
//        customTabbarController.user = user
//        customTabbarController.friends = friends
//        self.navigationController?.pushViewController(customTabbarController, animated: false)
        
        let messageController = MessageCollectionController()
        messageController.friends = friends
        messageController.user = user
        self.navigationController?.pushViewController(messageController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("login will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("login did appear")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("login did disappear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("login will disappear")
    }
}
