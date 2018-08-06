//
//  ViewController.swift
//  DemoTimer
//
//  Created by Nguyen Nam on 6/27/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer:Timer!
    var i:Int = 0
    
    @IBOutlet weak var imgFan: UIImageView!
    
    var time:Timer!
    var goc:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Cach 1
        
        
        //        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
        //            print("Hello")
        //        }
        
        // Cach 2
        //
        //        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(ViewController.chay), userInfo: nil, repeats: false)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.chay), userInfo: nil, repeats: true)
        
        
        
        
        
    }
    
    func chay() {
        i += 1
        if i == 5{
            timer.invalidate() // method stop runloop
            timer = nil // dinit timer
        }
        print("Hello World!")
    }
    
    
    @IBAction func sw_On(_ sender: Any) {
      
        if let sw = sender as? UISwitch{
            if sw.isOn{
                time = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (time) in
                    self.goc += 5
                    self.imgFan.transform = CGAffineTransform(rotationAngle: (CGFloat(self.goc) * CGFloat(M_PI)) / 180)

                })
                // 1 pi = 180 do
            }
            else{
                time.invalidate()
                time = nil
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }
    
    
}

