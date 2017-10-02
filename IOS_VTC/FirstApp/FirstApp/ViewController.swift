//
//  ViewController.swift
//  FirstApp
//
//  Created by Nguyen Nam on 7/31/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtInputName: UITextField!
    @IBOutlet weak var segRange: UISegmentedControl!
    @IBOutlet weak var progess: UIActivityIndicatorView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblNumber: UILabel!
    
    var i:Int = 0
    
    @IBOutlet var viewRoot: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.txtInputName.delegate = self
        txtInputName.placeholder = "Input your name "
        segRange.insertSegment(withTitle: "Forth", at: 3, animated: true)
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        
        
    }
    
    @IBAction func segChange(_ sender: Any) {
        let segment = sender as! UISegmentedControl
        lblName.text = segRange.titleForSegment(at: segment.selectedSegmentIndex)!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showHello(_ sender: Any) {
         self.progess.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (time) in
            self.lblName.text = "Hello " + self.txtInputName.text!
           self.progess.stopAnimating()
//          self.progess.isHidden = true
            self.progess.alpha = 0
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtInputName.resignFirstResponder()
        return true
    }
    
    @IBAction func changeValue(_ sender: UIStepper) {
        lblNumber.text = "\(Int(sender.value))"
    }
    
    @IBAction func nextPage(_ sender: UIPageControl) {
        viewRoot.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        pageControl.currentPage += 1
        
    }
    
}

