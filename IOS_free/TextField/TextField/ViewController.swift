//
//  ViewController.swift
//  TextField
//
//  Created by Nguyen Nam on 6/16/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.text = ""
        txtName.placeholder = "Input your name 🙏🏻"
        txtName.backgroundColor = UIColor.blue
        txtName.isSecureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

