//
//  Scene3ViewController.swift
//  NavigationLifeCircle
//
//  Created by Nguyen Nam on 6/21/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class Scene3ViewController: UIViewController {

    @IBAction func backtoPrevious(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func backtoRoot(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backtoView(_ sender: Any) {
        let manhinh = self.navigationController?.viewControllers[1] as! Scene2ViewController
        manhinh.hoten = "adsad"
        self.navigationController?.popToViewController(manhinh, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
