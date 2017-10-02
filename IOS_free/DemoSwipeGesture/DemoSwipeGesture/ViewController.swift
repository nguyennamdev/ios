
//
//  ViewController.swift
//  DemoSwipeGesture
//
//  Created by Nguyen Nam on 6/29/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgHinh: UIImageView!
    @IBOutlet var swipeBack: UISwipeGestureRecognizer!
    
    @IBOutlet var swipeNext: UISwipeGestureRecognizer!
    
    let arrayHinh:[String] = ["meo", "cho", "hinh","fan"]
    
    var index:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgHinh.image = UIImage(named: arrayHinh[index])
    }
    @IBAction func swipeNext(_ sender: Any) {
        index -= 1
        if index < 0{
            index = 0
        }
        imgHinh.image = UIImage(named: arrayHinh[index])
    }
    
    @IBAction func swipeBack(_ sender: Any) {
        index += 1
        if index >= arrayHinh.count - 1{
            index = arrayHinh.count - 1
        }
        imgHinh.image = UIImage(named: arrayHinh[index])
    }
   
    @IBAction func rotatoryImg(_ sender: Any) {
        let rota = sender as! UIRotationGestureRecognizer
        rota.view?.transform = (rota.view?.transform.rotated(by: rota.rotation))!
        rota.rotation = 0
    }
    
    
}

