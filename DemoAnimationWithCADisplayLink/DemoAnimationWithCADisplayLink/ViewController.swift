//
//  ViewController.swift
//  DemoAnimationWithCADisplayLink
//
//  Created by Nguyen Nam on 7/2/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let countLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    let introTextLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    var displayLink: CADisplayLink!
    var displayLink2: CADisplayLink!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(countLabel)
        countLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        
        self.view.addSubview(introTextLabel)
        introTextLabel.translatesAutoresizingMaskIntoConstraints = false
        introTextLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 12).isActive = true
        introTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        introTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // create cadisplaylink to animation
        displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .defaultRunLoopMode)
        
        
        displayLink2 = CADisplayLink(target: self, selector: #selector(handleUpdateIntroText(sender:)))
        displayLink2.add(to: .current, forMode: .defaultRunLoopMode)
    }
    
    
    let startValue: Double = 0
    let endValue: Double = 1000
    let startDate = Date()
    let duration: Double = 3
    
    // MARK:- fafaf
    
    @objc func handleUpdate(){
        let now = Date()
        let eslapsedTime = now.timeIntervalSince(startDate)
        
        if eslapsedTime > duration{
            self.countLabel.text = "\(endValue)"
            self.displayLink.invalidate()
        }else{
            // caculate percent eslapsedTime with duration
            let percent = eslapsedTime / duration
            let value = startValue + percent * (endValue - startValue)
            self.countLabel.text = "\(value)"
        }
    }
    
    let introDuration: Double = 5
    let endText = "Hello everybody! I am a developer. I come from Viet Nam. I Love code <3"
    let startTime = Date()
    
    @objc func handleUpdateIntroText(sender:CADisplayLink){
        let now = Date()
        let eslapsedTime = now.timeIntervalSince(startTime)
        
        if eslapsedTime > introDuration {
            self.introTextLabel.text = endText
            self.displayLink2.invalidate()
        }else{
            let percent = Int((eslapsedTime / introDuration) * 100)
            let indexByPercentOfText = Int(endText.count * percent / 100)
            
            let indexDistance = endText.index(endText.startIndex, offsetBy: indexByPercentOfText)
            // get text before index distance
            let value = String(endText.prefix(upTo: indexDistance))
            self.introTextLabel.text = value
        }
    }
}

