//
//  SelectTimeViewController.swift
//  ReuseableCustomPopup
//
//  Created by Nguyen Nam on 1/15/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class SelectTimeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func selectDate_touchUpInside(_ sender: Any) {
        // 1 : create story board reference to date popup story board
        let sb = UIStoryboard(name: "DatePopup", bundle: nil)
        // 2 : create popup 
        let popup = sb.instantiateInitialViewController() as! DatePopupViewController
        popup.showTime = true
        present(popup, animated: true, completion: nil)
    }

}
