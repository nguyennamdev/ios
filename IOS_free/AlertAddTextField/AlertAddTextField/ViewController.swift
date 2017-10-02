//
//  ViewController.swift
//  AlertAddTextField
//
//  Created by Nguyen Nam on 6/21/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alert:UIAlertController = UIAlertController(title: "Login", message:"vui long nhap thong tin", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (txtEmail) in
            txtEmail.placeholder = "Nhap Email ✉️"
            txtEmail.textColor = UIColor.brown
        }
        alert.addTextField { (txtPass) in
            txtPass.placeholder = "Nhap Password 🔑"
            txtPass.isSecureTextEntry = true
        }
        let btnOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive) { (btnLogin) in
            let email:String = alert.textFields![0].text!
            let password:String = alert.textFields![1].text!
            print(email,password)
        }
        let btnCancel:UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (btnCancel) in
            
        }
        alert.addAction(btnOK)
        alert.addAction(btnCancel)
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

