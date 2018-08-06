//
//  Extension.swift
//  DemoMessengerFB
//
//  Created by Nguyen Nam on 9/18/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

extension UIView{
    func addContraintWithFormat(format:String,views:UIView...){
        var dictionary = [String:UIView]()
        for (index,item) in views.enumerated() {
            let key = "v\(index)"
            dictionary[key] = item
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dictionary))
    }
}
