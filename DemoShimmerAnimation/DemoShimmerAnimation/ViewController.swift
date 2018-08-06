//
//  ViewController.swift
//  DemoShimmerAnimation
//
//  Created by Nguyen Nam on 6/30/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let grayTextLabel = UILabel()
        grayTextLabel.text = "Shimmer"
        grayTextLabel.textColor = .gray
        grayTextLabel.font = UIFont.systemFont(ofSize: 80)
        grayTextLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 400)
        grayTextLabel.textAlignment = .center
        view.addSubview(grayTextLabel)
        
        // create shiny text label to shimmer text
        let shinyTextLabel = UILabel()
        shinyTextLabel.text = "Shimmer"
        shinyTextLabel.textColor = .black
        shinyTextLabel.font = UIFont.systemFont(ofSize: 80)
        shinyTextLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 400)
        shinyTextLabel.textAlignment = .center
        
        view.addSubview(shinyTextLabel)
        
        // let make animation
        let gradientColor = CAGradientLayer()
        gradientColor.colors = [ UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientColor.locations = [0, 0.5, 1]
        
        gradientColor.frame = shinyTextLabel.frame
        
        let angle = 45 * Float.pi / 180
        gradientColor.transform = CATransform3DMakeRotation(CGFloat(angle), 0, 0, 1)
        shinyTextLabel.layer.mask = gradientColor
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -view.frame.width
        animation.toValue = view.frame.width
        animation.duration = 1
        animation.repeatCount = Float.infinity
        gradientColor.add(animation, forKey: "doesn'tmatterJustSomeKey")
        
        
        
    }

}

