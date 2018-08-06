//
//  FoodTableViewCell.swift
//  DemoSaveDataWithSQL
//
//  Created by Nguyen Nam on 12/27/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    //MARK : Properties
    
    var food:Food?
    
    @IBOutlet weak var ratingStackView: RatingControl!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        guard let food = self.food else {
            return
        }
        ratingStackView.rating = food.rate
        foodNameLabel.text = food.name
        foodImageView.image = UIImage(named: food.image!)
    }

}
