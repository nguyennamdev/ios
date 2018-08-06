//
//  Extensions.swift
//  DemoAppStore
//
//  Created by Nguyen Nam on 9/11/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit


extension UIView{
    func addContraintWithFormat(stringFormat:String, views:UIView...){
        var dictionary:[String:UIView] = [String:UIView]()
        for (index,item) in views.enumerated() {
            dictionary["v\(index)"] = item
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: stringFormat, options: NSLayoutFormatOptions(), metrics: nil, views: dictionary))
    }
}
