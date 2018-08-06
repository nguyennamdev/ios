//
//  ViewController.swift
//  DemoScrollView
//
//  Created by Nguyen Nam on 7/5/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func nextScene(_ sender: Any) {
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let scene2 = sb.instantiateViewController(withIdentifier: "MAN2") as! Man2ViewController
        self.navigationController?.pushViewController(scene2, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create a UIScrollView and auto layout
        
        let scroll:UIScrollView = UIScrollView()
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scroll.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scroll.widthAnchor.constraint(equalToConstant: 200).isActive = true
        scroll.heightAnchor.constraint(equalToConstant: 200).isActive = true
        scroll.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        scroll.isPagingEnabled = true
        
        // creat view red and auto layout
        let viewRed:UIView = UIView()
        scroll.addSubview(viewRed)
        viewRed.translatesAutoresizingMaskIntoConstraints = false
        viewRed.topAnchor.constraint(equalTo: scroll.topAnchor).isActive  = true
        viewRed.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true
        viewRed.widthAnchor.constraint(equalToConstant: 400).isActive = true
        viewRed.heightAnchor.constraint(equalToConstant: 200).isActive = true
        viewRed.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.06180713595, alpha: 1)
        viewRed.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
//        viewRed.rightAnchor.constraint(equalTo: scroll.rightAnchor).isActive = true
        
        //create view blue and auto layout
        let viewBlue:UIView = UIView()
        scroll.addSubview(viewBlue)
        viewBlue.translatesAutoresizingMaskIntoConstraints = false
        viewBlue.topAnchor.constraint(equalTo: scroll.topAnchor).isActive  = true
        viewBlue.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true
        viewBlue.widthAnchor.constraint(equalToConstant: 400).isActive = true
        viewBlue.heightAnchor.constraint(equalToConstant: 200).isActive = true
        viewBlue.backgroundColor = #colorLiteral(red: 0.2066597924, green: 0.103973411, blue: 1, alpha: 1)
        viewBlue.leftAnchor.constraint(equalTo: viewRed.rightAnchor).isActive = true
        viewBlue.rightAnchor.constraint(equalTo: scroll.rightAnchor).isActive = true
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

