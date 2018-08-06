//
//  Meal.swift
//  DemoImagePicker
//
//  Created by Nguyen Nam on 8/4/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation
import UIKit

class Meal {
    var name:String
    var image:UIImage?
    var rating:Int
    
    init?(name:String, image:UIImage?, rating:Int) {
        guard !name.isEmpty else {
            return nil
        }
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        self.name = name
        self.image = image
        self.rating = rating
    }
}
