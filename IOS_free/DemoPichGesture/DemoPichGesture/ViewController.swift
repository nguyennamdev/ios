//
//  ViewController.swift
//  DemoPichGesture
//
//  Created by Nguyen Nam on 6/29/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var pinchImg: UIPinchGestureRecognizer!
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func pinch_Img(_ sender: Any) {
        //print("Dang scale")
        
        let pinch = sender as! UIPinchGestureRecognizer
        img.transform = img.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

