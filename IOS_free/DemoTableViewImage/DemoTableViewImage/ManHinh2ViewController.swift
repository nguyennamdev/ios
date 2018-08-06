//
//  ManHinh2ViewController.swift
//  DemoTableViewImage
//
//  Created by Nguyen Nam on 6/22/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ManHinh2ViewController: UIViewController {
    
    var tenHinh:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: tenHinh)!)
        // Do any additional setup after loading the view.
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
