//
//  FirstViewController.swift
//  ReuseableCustomPopup
//
//  Created by Nguyen Nam on 1/15/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

   
    @IBOutlet weak var titleLabel: UILabel!
    var observer:NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       observer =  NotificationCenter.default.addObserver(forName: NSNotification.Name.someName, object:nil, queue: OperationQueue.main) { (notification) in
            let dateVC = notification.object as! DatePopupViewController
            self.titleLabel.text = dateVC.formattedDate
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        guard let observer = observer else {
            return
        }
        NotificationCenter.default.removeObserver(observer)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "showDatePopupSegue":
            let popup = segue.destination as? DatePopupViewController
            popup?.showTime = true
        default:
            break
        }
    }


}

