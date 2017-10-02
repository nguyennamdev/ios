//
//  ViewController.swift
//  CuocDuaKiThu
//
//  Created by Nguyen Nam on 7/6/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sldThree: UISlider!
    @IBOutlet weak var swThree: UISwitch!
    @IBOutlet weak var sldTwo: UISlider!
    @IBOutlet weak var swTwo: UISwitch!
    @IBOutlet weak var sldOne: UISlider!
    @IBOutlet weak var swOne: UISwitch!
    @IBOutlet weak var btnPlay: UIButton!
    var timer:Timer!
    var timer2:Timer!
    @IBOutlet weak var lblMessage: UILabel!
    
    
    @IBAction func toPlay(_ sender: Any) {
        
        sldOne.value = 0
        sldTwo.value = 0
        sldThree.value = 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.run), userInfo: nil, repeats: true)
    
        timer2 = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (timer) in
            self.lblMessage.alpha = 1
        })
        
    }
    
    @objc func run() {
        if swOne.isOn || swTwo.isOn || swThree.isOn{
            btnPlay.alpha = 0
            lblMessage.alpha  = 0
            if sldOne.value >= 70{
                sldTwo.value += 8
                sldOne.value += 3
                sldThree.value += 2
            }
            else{
                sldOne.value += 3
                sldTwo.value += 2
                sldThree.value += 2
                
            }
            
            
            if sldTwo.value == sldTwo.maximumValue{
                let alert:UIAlertController = UIAlertController(title: "Kết quả", message: "Cô gái thuộc về chàng trai khác :((", preferredStyle: UIAlertControllerStyle.alert)
                let action:UIAlertAction = UIAlertAction(title: "Bỏ cuộc :(", style: UIAlertActionStyle.default, handler: { (btn) in
                    self.sldThree.value = 0
                    self.sldOne.value = 0
                    self.sldTwo.value = 0
                    self.btnPlay.alpha = 1
                    
                })
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                timer.invalidate()
                timer = nil
                timer2.invalidate()
                timer2 = nil
            }
        }
        else{
            let alert:UIAlertController = UIAlertController(title: "Thông báo", message: "Phải chọn người muốn đến với cô gái", preferredStyle: UIAlertControllerStyle.alert)
            let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            timer.invalidate()
            timer = nil
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "backgroud"))
        lblMessage.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        lblMessage.layer.borderWidth = 1
        lblMessage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lblMessage.layer.borderColor = UIColor.cyan.cgColor
        lblMessage.layer.cornerRadius = 5
        lblMessage.clipsToBounds = true
        btnPlay.layer.cornerRadius = 5
        btnPlay.clipsToBounds  = true
        sldOne.maximumValue = 100
        sldTwo.maximumValue = 100
        sldThree.maximumValue = 100
        sldOne.value = 0
        sldTwo.value = 0
        sldThree.value = 0
        lblMessage.alpha = 0
        sldOne.maximumTrackTintColor = UIColor.red
        sldOne.minimumTrackTintColor = UIColor.white
        sldTwo.maximumTrackTintColor = UIColor.red
        sldTwo.minimumTrackTintColor = UIColor.blue
        sldThree.maximumTrackTintColor = UIColor.red
        sldThree.minimumTrackTintColor = UIColor.green
        sldOne.maximumValueImage = UIImage(named: "girl")
        sldTwo.maximumValueImage = UIImage(named: "girl")
        sldThree.maximumValueImage = UIImage(named: "girl")
        sldOne.setThumbImage(#imageLiteral(resourceName: "renam"), for: UIControlState.normal)
        sldTwo.setThumbImage(#imageLiteral(resourceName: "user2"), for: UIControlState.normal)
        sldThree.setThumbImage(#imageLiteral(resourceName: "user-2"), for: UIControlState.normal)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

