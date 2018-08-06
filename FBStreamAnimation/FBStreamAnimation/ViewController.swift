//
//  ViewController.swift
//  FBStreamAnimation
//
//  Created by Nguyen Nam on 7/8/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    
    @objc func handleTap(){
        (0...10).forEach { (_) in
            generateAnimationViews()
        }
    }
    
    fileprivate func generateAnimationViews(){
        let emojiIconImageView = UIImageView(image: #imageLiteral(resourceName: "heart"))
        let dimension = 32 + drand48() * 10
        emojiIconImageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        // animation
        CATransaction.begin()
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        CATransaction.setCompletionBlock {
            UIView.transition(with: emojiIconImageView, duration: 0.1, options: .transitionCrossDissolve, animations: {
                emojiIconImageView.isHidden = true
            }, completion: { (_) in
                emojiIconImageView.removeFromSuperview()
            })
        }
        emojiIconImageView.layer.add(animation, forKey: nil)
        CATransaction.commit()
        view.addSubview(emojiIconImageView)
    }
    
    func customPath() -> UIBezierPath {
        let path = UIBezierPath()
        // get end point of view
        let screenSize = UIScreen.main.bounds
        let viewEndPoint = CGPoint(x: screenSize.width, y: screenSize.height)
        
        // make start point
        let startPoint = CGPoint(x: viewEndPoint.x / 2, y: viewEndPoint.y)
        path.move(to: startPoint)
        // make end point
        let endPoint = CGPoint(x: viewEndPoint.x / 2, y: 10)
        
        // make curve line
        let randomXCP1 = viewEndPoint.x * CGFloat(drand48())
        let randomXCP2 = viewEndPoint.x * CGFloat(drand48())

        let cp1 = CGPoint(x: randomXCP1, y: viewEndPoint.y - (viewEndPoint.y / 3))
        let cp2 = CGPoint(x: randomXCP2, y: viewEndPoint.y - (viewEndPoint.y / 2))

        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)

        return path
    }
    
}





