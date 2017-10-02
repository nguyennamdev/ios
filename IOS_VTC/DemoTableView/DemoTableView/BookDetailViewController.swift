//
//  BookDetailViewController.swift
//  DemoTableView
//
//  Created by Nguyen Nam on 8/8/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var lblBookPrice: UILabel!
    @IBOutlet weak var lblBookAuthor: UILabel!
    @IBOutlet weak var lblBookTitle: UILabel!
    @IBOutlet weak var imgBook: UIImageView!
    
    public var book:Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBookTitle.numberOfLines = 0
//        if(book != nil){
//            showBookDetail(book: book!)
//        }
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(book != nil){
            showBookDetail(book: book!)
        }
    }

    private func showBookDetail(book:Book){
        lblBookPrice.text = "Price : " +  String(Int(book.price))
        lblBookTitle.text = book.title
        lblBookAuthor.text = "Author : " + book.author
        imgBook.image = book.image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case "editBookSegue":
            let aeBookVC = segue.destination as? AddEditBookViewController
            aeBookVC?.book = book
        default:
            break
        }
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
