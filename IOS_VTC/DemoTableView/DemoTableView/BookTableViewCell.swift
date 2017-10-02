//
//  BookTableViewCell.swift
//  DemoTableView
//
//  Created by Nguyen Nam on 8/7/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    public var book:Book? = nil
    
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var lblBookTitle: UILabel!
    @IBOutlet weak var lblBookPrice: UILabel!
    @IBOutlet weak var lblBookAuthor: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        if book != nil{
            lblBookTitle.text = book?.title
            lblBookPrice.text = "\(String(describing: Int(book!.price)))"
            lblBookAuthor.text = book?.author
            imgBook.image = book?.image
        }
        
        
    }

}
