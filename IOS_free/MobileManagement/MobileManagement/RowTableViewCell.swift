//
//  RowTableViewCell.swift
//  MobileManagement
//
//  Created by Nguyen Nam on 6/23/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class RowTableViewCell: UITableViewCell {
    @IBOutlet weak var lblMobileID: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblManufacture: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
