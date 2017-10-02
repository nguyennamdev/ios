//
//  UpdateViewController.swift
//  DemoNavigationController
//
//  Created by Nguyen Nam on 8/2/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var txtBookTitle: UITextField!
    @IBOutlet weak var txtBookAuthor: UITextField!
    
    var book:Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtBookAuthor.delegate = self
        txtBookTitle.delegate = self
        // Do any additional setup after loading the view.
        
        if book != nil {
            txtBookTitle.text = book?.title
            txtBookAuthor.text = book?.author
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func updateBook(_ sender: UIBarButtonItem) {
        book?.title = txtBookTitle.text!
        book?.author = txtBookAuthor.text!
        self.navigationController?.popViewController(animated: true)
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
