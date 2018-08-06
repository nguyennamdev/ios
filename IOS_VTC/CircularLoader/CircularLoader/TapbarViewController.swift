//
//  TapbarViewController.swift
//  CircularLoader
//
//  Created by Nguyen Nam on 12/11/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class TapbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("tap bar did load")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("tap bar will apprear")
    }

    override func viewDidAppear(_ animated: Bool) {
        print("tap bar did app")
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
