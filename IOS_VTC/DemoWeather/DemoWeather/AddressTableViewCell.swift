//
//  AddressTableViewCell.swift
//  DemoWeather
//
//  Created by Nguyen Nam on 8/30/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let summaryLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let cityLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize:32)
        label.textColor  = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return label
    }()
    
    let temperatureLabel:UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupViews()
        // Configure the view for the selected state
    }
    
    func setupViews(){
        addSubview(summaryLabel)
        addSubview(cityLabel)
        addSubview(temperatureLabel)
        addContraintWithFormat(stringFormat: "H:|-20-[v0]", views: summaryLabel)
        addContraintWithFormat(stringFormat: "V:|-5-[v0]-5-[v1]-10-|", views: summaryLabel,cityLabel)
        addContraintWithFormat(stringFormat: "H:|-20-[v0]", views: cityLabel)
        addContraintWithFormat(stringFormat: "H:[v0]-10-|", views: temperatureLabel)
        addContraintWithFormat(stringFormat: "V:|[v0]|", views: temperatureLabel)
    }
  }
