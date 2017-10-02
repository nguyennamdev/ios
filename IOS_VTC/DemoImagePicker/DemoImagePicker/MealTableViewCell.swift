//
//  MealTableViewCell.swift
//  DemoImagePicker
//
//  Created by Nguyen Nam on 8/4/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblMealName: UILabel!
    @IBOutlet weak var ratingMeal: RatingController!
    @IBOutlet weak var imgMeal: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
