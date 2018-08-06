//
//  DatePopupViewController.swift
//  ReuseableCustomPopup
//
//  Created by Nguyen Nam on 1/15/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class DatePopupViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    var showTime:Bool = false
    
    var onSave:((_ date:String) -> Void)?
    
    var formattedDate:String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: datePicker.date)
    }
    
    var formattedTime:String {
        let formatted = DateFormatter()
        formatted.dateStyle = .short
        return formatted.string(from: datePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if showTime {
            datePicker.datePickerMode = .time
            print("showtime is true")
        }
    }

    @IBAction func save_touchUpInside(_ sender: UIButton) {
     
        if showTime {
            // Notification use for first view
            NotificationCenter.default.post(name: NSNotification.Name.someName, object: self)
        }else{
            // Callbacks use for second view
            onSave!(formattedDate)
        }
        
        
        
        dismiss(animated: true, completion: nil)
    }

}

extension NSNotification.Name {
    static let someName = NSNotification.Name(rawValue: "someName")
}
