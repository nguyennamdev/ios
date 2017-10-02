//
//  ViewController.swift
//  ActionSheet
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let action:UIAlertController = UIAlertController(title: "Thông báo", message: "Xin chào bạn!", preferredStyle: UIAlertControllerStyle.actionSheet)
        let btnOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil)
        action.addAction(btnOK)
        present(action, animated: true, completion: nil)
    }

}

