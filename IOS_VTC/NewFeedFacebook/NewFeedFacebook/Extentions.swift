//
//  Extentions.swift
//  NewFeedFacebook
//
//  Created by Nguyen Nam on 8/21/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func addConstraintsWithFormat(format:String , views:UIView...) {
        var viewDictionany = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewDictionany[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionany))
    }
}
extension UIImage{
    func resizeImage(newSize:CGSize) -> UIImage {
        guard self.size != newSize else {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension Int{
    static func convertToThousand(number:Int) -> String {
        if number > 1000{
            return "\(number / 1000)K"
        }
        return "\(number)"
    }
}
