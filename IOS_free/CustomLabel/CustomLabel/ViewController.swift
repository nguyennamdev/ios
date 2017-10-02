//
//  ViewController.swift
//  CustomLabel
//
//  Created by Nguyen Nam on 6/16/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblNam: UILabel!
    
    @IBOutlet weak var lblHello: UILabel!
    
    @IBOutlet weak var lblFriend: UILabel!
    
    @IBOutlet weak var lblCircle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblFriend.layer.borderWidth = 2
        lblFriend.layer.borderColor = UIColor.black.cgColor
        
        lblHello.layer.borderWidth = 2
        lblHello.layer.borderColor = UIColor.green.cgColor
        lblHello.layer.cornerRadius = CGFloat(5)
        lblHello.clipsToBounds = true
        
        lblNam.font = UIFont(name: "Kefa", size: 25)
        
        
        lblCircle.text = "Xin chao Nam 😂"
        lblCircle.numberOfLines = 0
        lblCircle.textAlignment = .center
        lblCircle.layer.cornerRadius = lblCircle.frame.size.width / 2
        lblCircle.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

