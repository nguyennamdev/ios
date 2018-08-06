//
//  ViewController.swift
//  FBLikeAnimation
//
//  Created by Nguyen Nam on 7/12/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let iconsContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        // configuration subviews
        let iconHeight: CGFloat = 36
        let padding: CGFloat = 8

        let arrangedSubviews = [#imageLiteral(resourceName: "like-emoticon"), #imageLiteral(resourceName: "love"), #imageLiteral(resourceName: "haha"), #imageLiteral(resourceName: "Facebook-Wow")].map({ (image) -> UIImageView in
            let imageView = UIImageView()
            imageView.image = image
            imageView.layer.cornerRadius = iconHeight / 2
            imageView.isUserInteractionEnabled = true
            return imageView
        })
    
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        
        
        containerView.addSubview(stackView)
      
        // caculate frame
        let iconsNum: CGFloat = CGFloat(stackView.arrangedSubviews.count)
        let widthContainer = (iconsNum + 1) * padding + (iconsNum * iconHeight)
        containerView.frame = CGRect(x: 0, y: 0, width: widthContainer, height: iconHeight + (2 * padding))
        containerView.layer.cornerRadius = containerView.frame.height / 2
        stackView.frame = containerView.frame
        return containerView
    }()
    
    lazy var longGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        return gesture
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        view.addGestureRecognizer(longGesture)
    }
    
    @objc fileprivate func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            self.handleLongPressBegan(gesture: gesture)
        }else if gesture.state == .ended{
            UIView.animate(withDuration: 0.1, animations: {
                let stackView = self.iconsContainerView.subviews.first as? UIStackView
                stackView?.subviews.forEach({ (view) in
                    view.transform = CGAffineTransform.identity
                })
            }, completion: { (_) in
                self.iconsContainerView.removeFromSuperview()
            })
        }else if gesture.state == .changed {
            self.handleLongPressChange(gesture: gesture)
        }
    }
    
    fileprivate func handleLongPressBegan(gesture: UILongPressGestureRecognizer) {
        view.addSubview(iconsContainerView)
        let pressLocation = gesture.location(in: self.view)
        
        let centerX = (view.frame.width - iconsContainerView.frame.width) / 2
        
        // tranformation of the icon view
        iconsContainerView.transform = CGAffineTransform(translationX: centerX, y: pressLocation.y)
        iconsContainerView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.iconsContainerView.alpha = 1
            self.iconsContainerView.transform = CGAffineTransform(translationX: centerX, y: pressLocation.y - self.iconsContainerView.frame.height)
        })
    
    }
    
    func handleLongPressChange(gesture: UILongPressGestureRecognizer) {
        let moveLocation = gesture.location(in: iconsContainerView)
        
        // hit test
        let hitTestView = iconsContainerView.hitTest(moveLocation, with: nil)

        if hitTestView is UIImageView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
            }, completion: nil)
        }

    }
}









