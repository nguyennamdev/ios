//
//  ViewController.swift
//  Buoi2
//
//  Created by Nguyen Nam on 6/15/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "hinh.jpg")!)
    }
    
    // Actions
    @IBAction func showName(_ sender: Any) {
        self.lblName.text = "Xin chao ! " + "Nam"
        
    }
    
    @IBAction func loadImage(_ sender: Any) {
        img.image = UIImage(named:"hinh.jpg")
    }
    
    
    @IBAction func loadImageInternet(_ sender: Any) {
        let url = URL(string: "http://taihinhanhdep.xyz/wp-content/uploads/2017/06/xem-hinh-anh-be-trai-de-thuong-nhat-qua-dat-.jpg")
        do{
            let data = try Data(contentsOf: url!)
            img.image = UIImage(data: data)
        }catch{
            print("co Loi anh")
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

