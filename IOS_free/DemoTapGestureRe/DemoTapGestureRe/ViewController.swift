//
//  ViewController.swift
//  DemoTapGestureRe
//
//  Created by Nguyen Nam on 6/29/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //@IBOutlet var tap: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        tap.numberOfTapsRequired = 2
//        tap.numberOfTouchesRequired = 2
    }

//    @IBAction func tapShowMes(_ sender: UITapGestureRecognizer) {
//        print("Hello!")
//    }
    @IBAction func tapView(_ sender: Any) {
        let tap = sender as! UITapGestureRecognizer
        print(tap.location(in: view))
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "hinh")
        img.frame.size = CGSize(width: 100, height: 50)
        img.center = tap.location(in: view)
        view.addSubview(img)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

