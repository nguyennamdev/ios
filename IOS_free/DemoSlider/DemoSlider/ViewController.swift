//
//  ViewController.swift
//  DemoSlider
//
//  Created by Nguyen Nam on 6/25/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sldGiaTri: UISlider!
    
    @IBOutlet weak var lblHienThi: UILabel!
    
    @IBOutlet weak var sldRed: UISlider!
    @IBOutlet weak var sldGreen: UISlider!
    @IBOutlet weak var sldBlue: UISlider!
    @IBAction func sld_change(_ sender: UISlider) {
        lblHienThi.text! = String(Int(sldGiaTri.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sldGiaTri.maximumValue = 100
        sldGiaTri.minimumValue = 1
        sldGiaTri.value = 50
        lblHienThi.text! = String(sldGiaTri.value)
        sldGiaTri.setThumbImage(UIImage(named: "meo"), for: UIControlState.normal)
    }
    
    
    @IBAction func sld_chonmau(_ sender: Any) {
        view.backgroundColor = UIColor(colorLiteralRed: sldRed.value, green: sldGreen.value, blue: sldBlue.value, alpha: 1)
    }
    
    
}

