//
//  AddViewController.swift
//  MobileManagement
//
//  Created by Nguyen Nam on 6/23/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var txtMobileID: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtConfi: UITextField!
    @IBOutlet weak var txtManufacture: UITextField!
    @IBOutlet weak var txtModel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func toAdd(_ sender: Any) {
        let mobile:Mobile = Mobile(txtMobileID.text!, txtModel.text!, txtManufacture.text!, txtConfi.text!, Double(txtPrice.text!), Int(txtAmount.text!))
        let view = navigationController?.viewControllers[0] as! ViewController
        view.mobile = mobile
        self.navigationController?.popToViewController(view, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
