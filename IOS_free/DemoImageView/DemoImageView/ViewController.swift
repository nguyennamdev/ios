//
//  ViewController.swift
//  DemoImageView
//
//  Created by Nguyen Nam on 6/19/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imgHinh: UIImageView!
    
    @IBOutlet weak var hinh2: UIImageView!
    
    @IBOutlet weak var hinh3: UIImageView!
    
    @IBOutlet weak var imgInternet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgHinh.image = UIImage(named: "hinh")
        
        hinh2.image = UIImage(named:"meo")
        hinh2.layer.cornerRadius = hinh2.frame.size.width / 2
        hinh2.clipsToBounds = true
        hinh3.image = UIImage(named: "cho")
        hinh3.layer.borderWidth = 2
        hinh3.layer.borderColor = UIColor.red.cgColor
        
        let url:URL = URL(string: "https://scontent.fhan3-1.fna.fbcdn.net/v/t1.0-9/18118609_804143983067964_8745637223960202138_n.jpg?oh=93ecacffebe331fa4772588c05c95910&oe=59D92823")!
        do{
            let data:Data = try Data(contentsOf: url)
            imgInternet.image = UIImage(data: data)
        }catch {
            print("Hinh co loi")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

