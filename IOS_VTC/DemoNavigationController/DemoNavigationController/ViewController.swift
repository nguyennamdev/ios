//
//  ViewController.swift
//  DemoNavigationController
//
//  Created by Nguyen Nam on 8/2/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    var book:Book?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        book = Book()
        book?.title = "Swift Language"
        book?.author = "I don't know "
//        showBookInfo(book: book!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showBookInfo(book: book!)
    }
    
    private func showBookInfo(book:Book){
        lblTitle.text = book.title
        lblAuthor.text = book.author
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "Update":
            let bookUpdateViewController = segue.destination as? UpdateViewController
            bookUpdateViewController?.book = book
        default:
            print("Don't have segue");
        }
    }
    
}

