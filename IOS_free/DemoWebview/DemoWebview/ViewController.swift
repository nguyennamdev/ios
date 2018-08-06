//
//  ViewController.swift
//  DemoWebview
//
//  Created by Nguyen Nam on 6/27/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var txtAddress: UITextField!
    
    
    var arrayHistory:Array<String> =  Array<String>()
    var index:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        if arrayHistory.count < 1{
            print("Don't have history")
        }
        else{
            index = index - 1
            if index < 0 {
                index = 0
            }
            let url:URL = URL(string: arrayHistory[index])!
            let req:URLRequest = URLRequest(url: url)
            web.loadRequest(req)
            txtAddress.text! = arrayHistory[index]
        }
        
    }
    @IBAction func btnNext(_ sender: Any) {
        if arrayHistory.count < 1{
            print("Don't have history")
        }
        else{
            index  = index + 1
            if index > arrayHistory.count - 1{
                index = arrayHistory.count - 1
            }
            let url:URL = URL(string: arrayHistory[index])!
            let req:URLRequest = URLRequest(url: url)
            web.loadRequest(req)
            txtAddress.text! = arrayHistory[index]
        }
    }
    
    @IBAction func btnReload(_ sender: Any) {
        web.reload()
    }
    @IBAction func btnSearch(_ sender: Any) {
        if let url = URL(string: txtAddress.text!){
            
            var link = txtAddress.text!
            
            if link.hasPrefix("https://") || link.hasPrefix("http://"){
                let rq:URLRequest = URLRequest(url: url)
                web.loadRequest(rq)
                
            }
            else{
                link = "http://\(link)"
                let url2:URL = URL(string: link)!
                let req:URLRequest = URLRequest(url: url2)
                web.loadRequest(req)
            }
            
            arrayHistory.append(link)
            index = arrayHistory.count - 1
        }
        else{
            print("Address Error")
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

