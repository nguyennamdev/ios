//
//  ViewController.swift
//  CoreAnimation
//
//  Created by Nguyen Nam on 7/5/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var viewAnimate: UIView!
    @IBOutlet weak var animateViewHeightConstaint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(transitionView)))
        
        // MARK:- Basic animate with spring
        // use to postion, alpha ....
        /*
         UIView.animate(withDuration: 2, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: .repeat, animations: {
         // animate with change y position
         //            self.viewAnimate.frame = CGRect(x: self.viewAnimate.frame.origin.x, y: 300, width: self.viewAnimate.frame.width, height: self.viewAnimate.frame.height)
         
         // animate with tranform scale
         //            self.viewAnimate.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
         
         // animate with rotate
         self.viewAnimate.transform = CGAffineTransform(rotationAngle: 0.5)
         
         }, completion: nil)
         */
        
        
        // MARK:- Animation with keyframes
        // use to animate block animations
        /*
        let origionalCenter = self.viewAnimate.center
        
        UIView.animateKeyframes(withDuration: 4, delay: 0, options: [], animations: {
            // first animate
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                self.viewAnimate.center.x += 50
                self.viewAnimate.center.y -= 10
            })
            // second animate
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4, animations: {
                self.viewAnimate.transform = CGAffineTransform(rotationAngle: 0.5)
            })
            // third animate
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.35, animations: {
                self.viewAnimate.transform = CGAffineTransform(rotationAngle: 0)
                self.viewAnimate.center = origionalCenter
            })
        }, completion: nil)
        */
        
        
        // MARK:- Animate with auto layout
        /*
         animateViewHeightConstaint.constant = 100
         UIView.animate(withDuration: 2, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.6, options: .curveEaseIn, animations: {
         self.view.layoutIfNeeded()
         }, completion: nil)*/
        
        // MARK:- Animate with layer
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0
        opacityAnimation.toValue = 1
        
        // MARK:- group animation
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 1.5
        
        let groupAnimate = CAAnimationGroup()
        groupAnimate.beginTime = CACurrentMediaTime() + 0.5
        groupAnimate.duration = 2
        groupAnimate.fillMode = kCAFillModeForwards
//        groupAnimate.repeatCount = Float.infinity
        groupAnimate.autoreverses = false
        
        // animate layer with spring
        let springAnimate = CASpringAnimation(keyPath: "position.y")
        springAnimate.fromValue = viewAnimate.layer.position.y
        springAnimate.toValue = viewAnimate.layer.position.y + 100
        springAnimate.damping = 5
        springAnimate.mass = 1
        springAnimate.stiffness = 150
        springAnimate.initialVelocity = 10

        groupAnimate.delegate = self
        groupAnimate.animations = [ opacityAnimation, scaleAnimation, springAnimate]
        viewAnimate.layer.add(groupAnimate, forKey: nil)
    }
    
    @objc func transitionView(){
        // MARK:- Animate with transistion
        // use to add view, hidden, remove view
        UIView.transition(with: viewAnimate, duration: 2, options: [.transitionCurlUp, .repeat], animations: {
            self.viewAnimate.isHidden = true
        }, completion: nil)
     
    }
}

extension ViewController : CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        viewAnimate.frame.origin.y += 100
    }
    
    
}

