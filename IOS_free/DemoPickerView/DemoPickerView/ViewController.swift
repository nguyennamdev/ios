//
//  ViewController.swift
//  DemoPickerView
//
//  Created by Nguyen Nam on 6/30/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var picker: UIPickerView!

    @IBOutlet weak var lblHienThi: UILabel!
    
    
    let subject:[[String]] = [["Ios","Android"],["PHP", "NodeJS"],["Dog", "Cat", "Cow", "Bear", "Stock", "Tiger", "Leopard"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return subject[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subject[component][row]
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return subject.count // number of column
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblHienThi.text! = subject[component][row]
    }
    
    
   

}



