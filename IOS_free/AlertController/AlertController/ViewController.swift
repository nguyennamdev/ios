//
//  ViewController.swift
//  AlertController
//
//  Created by Nguyen Nam on 6/19/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func btn_HienThongBao(_ sender: Any) {
        let alert:UIAlertController = UIAlertController(title: "Thông Báo", message: "Xin chào !", preferredStyle: .alert) // Create Alert Controller
        
        let btnOK:UIAlertAction = UIAlertAction(title: "Hello", style: .default) { (btn) in
            print("Hello!")
        } // Create Positive Button  Action in Alert
        let btnCancel:UIAlertAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil) // Create Negative Button  Action in Alert
        alert.addAction(btnOK) // add button to alert
        alert.addAction(btnCancel)
        present(alert, animated: true, completion: nil)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

