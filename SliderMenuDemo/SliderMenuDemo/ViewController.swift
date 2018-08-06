//
//  ViewController.swift
//  SliderMenuDemo
//
//  Created by Nguyen Nam on 1/2/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leftSlideViewContraint: NSLayoutConstraint!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var slideView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftSlideViewContraint.constant = -175
        blurView.layer.cornerRadius = 15
        //        slideView.layer.shadowColor = UIColor.blue.cgColor
        //        slideView.layer.shadowOpacity = 1
        //
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleShowMenu(sender:)))
        swipeRightGesture.direction = .right
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleHideMenu(sender:)))
        swipeLeftGesture.direction = .left
   
        view.addGestureRecognizer(swipeLeftGesture)
        view.addGestureRecognizer(swipeRightGesture)
    }
    
    
    func handleShowMenu(sender:UISwipeGestureRecognizer)  {
        if leftSlideViewContraint.constant < 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.leftSlideViewContraint.constant += 175
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func handleHideMenu(sender:UISwipeGestureRecognizer)  {
        if leftSlideViewContraint.constant == 0 {
            UIView.animate(withDuration: 0.5, animations: { 
                self.leftSlideViewContraint.constant -= 175
                self.view.layoutIfNeeded()
            })
           
        }
    }
    
}
