//
//  ViewController.swift
//  DemoAnimation
//
//  Created by Nguyen Nam on 8/27/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let zoomImageView = UIImageView()
    let startingFrame = CGRect(x: 0, y: 0, width: 200, height: 100)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        zoomImageView.frame = startingFrame
        zoomImageView.image = UIImage(named: "cho")
        zoomImageView.isUserInteractionEnabled = true
        zoomImageView.contentMode = .scaleAspectFill
        zoomImageView.clipsToBounds = true
        
        zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animation)))
        view.addSubview(zoomImageView)
    }
    
    func animation(){
        UIView.animate(withDuration: 0.75) { 
            let height = (self.view.frame.width / self.startingFrame.width) * self.startingFrame.height
            let y = self.view.frame.height / 2 - height / 2
            self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

