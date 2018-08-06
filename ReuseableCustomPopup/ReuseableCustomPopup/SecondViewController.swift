//
//  SecondViewController.swift
//  ReuseableCustomPopup
//
//  Created by Nguyen Nam on 1/15/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "showDatePopupSegue":
            let popup = segue.destination as? DatePopupViewController
            popup?.showTime = false
            // 1. Assign to a function
            popup?.onSave = onSave(date:)
            
            // or use a closure
            /*
            popup?.onSave = { (date:String) -> Void in
                self.titleLabel.text = date
            }
            */
        default:
            break
        }
    }
    
    func onSave(date:String){
        titleLabel.text = date
    }
    
    
}

