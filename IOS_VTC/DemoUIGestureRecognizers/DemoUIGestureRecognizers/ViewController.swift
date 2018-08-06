//
//  ViewController.swift
//  DemoUIGestureRecognizers
//
//  Created by Nguyen Nam on 8/14/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var imgLove: UIImageView!
    
    private var imgOriginal:CGAffineTransform?
    private var imgMaxScale:CGAffineTransform?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imgOriginal = imgLove.transform
        imgMaxScale = view.transform // assign max scale = 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func scaleImage(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began || sender.state == .changed{
            imgLove.transform = imgLove.transform.scaledBy(x: sender.scale, y: sender.scale)
//                minSize += sender.scale
            sender.scale = 1
            if imgLove.frame.width > view.frame.width{
                imgLove.transform = imgMaxScale!
            }
        }
        else if sender.state == .ended{
            imgLove.transform = imgOriginal!
        }
    }
    
}

