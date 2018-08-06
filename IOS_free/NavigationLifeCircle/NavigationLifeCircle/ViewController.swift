//
//  ViewController.swift
//  NavigationLifeCircle
//
//  Created by Nguyen Nam on 6/20/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtHoTen: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("View1 did load")
    }
    
    //Appear : Xuat hien
    override func viewWillAppear(_ animated: Bool) {
        print("View1 will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("View1 did appear")
    }
    
    
    
    //Disappear : Bien mat
    
    override func viewWillDisappear(_ animated: Bool) {
        print("View1 will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("View1 did disappear")
    }

    @IBAction func goto_scene(_ sender: Any) {
        // B1 : Tao 1 Storyboard
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // B2 : Tao man hinh moi
        let scene = sb.instantiateViewController(withIdentifier: "Scene2") as! Scene2ViewController
        
        if txtHoTen.text == ""{
            let alert:UIAlertController = UIAlertController(title: "Thong bao", message: "Phai nhap du lieu", preferredStyle: UIAlertControllerStyle.alert)
            let button:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(button)
            present(alert, animated: true, completion: nil)
        }
        else{
             scene.hoten = txtHoTen.text
            self.navigationController?.pushViewController(scene, animated: true)
        }
        
        // B3 : Navigation push
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

