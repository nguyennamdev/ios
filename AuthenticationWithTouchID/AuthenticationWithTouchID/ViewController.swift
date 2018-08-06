//
//  ViewController.swift
//  AuthenticationWithTouchID
//
//  Created by Nguyen Nam on 7/15/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = UIButton(type: UIButtonType.system)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        loginButton.center = view.center
        loginButton.setTitle("login", for: .normal)
        
    }
    
    @objc func handleLogin(){
        let authContext = LAContext()
        let authResson = "Please use Touch ID to sign in application"
        var authError: NSError?

        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: authResson, reply: { (success, error) in
                if success {
                    print("authenticate successfully")
                }else{
                    if let err = error {
                        self.ss(error: err as NSError)
                    }
                }
            })
        }else{
            print(authError?.localizedDescription ?? "")
        }
    }
    
    func ss(error: NSError) {
        switch error.code {
        case LAError.appCancel.rawValue :
            print("app canceled")
        case LAError.authenticationFailed.rawValue :
            print("authentication failed")
        default:
            return
        }
    }

    @IBAction func assss(_ sender: UIButton) {
        let view2 = ViewController2()
        present(view2, animated: true, completion: nil)
    }
    

}

