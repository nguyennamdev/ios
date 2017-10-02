//
//  Scene2ViewController.swift
//  NavigationLifeCircle
//
//  Created by Nguyen Nam on 6/20/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class Scene2ViewController: UIViewController {
    var hoten:String!
    @IBOutlet weak var txtHoTenScene2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View2 did load")
        txtHoTenScene2.text = hoten
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextView(_ sender: Any) {
        //Storyboard
        
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let scene3 = sb.instantiateViewController(withIdentifier: "Scene3") as! Scene3ViewController
        self.navigationController?.pushViewController(scene3, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Appear : Xuat hien
    override func viewWillAppear(_ animated: Bool) {
        print("View2 will appear")
        txtHoTenScene2.text = hoten
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("View2 did appear")
        
    }
    
    
    
    //Disappear : Bien mat
    
    override func viewWillDisappear(_ animated: Bool) {
        print("View2 will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("View2 did disappear")
    }
    

}
