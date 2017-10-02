//
//  DongTableViewCell.swift
//  DemoTableViewImage
//
//  Created by Nguyen Nam on 6/22/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class DongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgHinh: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
