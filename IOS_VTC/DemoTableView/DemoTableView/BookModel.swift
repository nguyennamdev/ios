//
//  BookModel.swift
//  DemoTableView
//
//  Created by Nguyen Nam on 8/7/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation
import UIKit

class Book: NSObject {
    var title:String = ""
    var image:UIImage?
    var author:String = ""
    var price:Double = 0
    
    override init() {
        super.init()
    }
    
    init(_ title:String, _ author:String, _ image:UIImage, _ price:Double) {
        self.title = title
        self.author = author
        self.image = image
        self.price = price
    }
}
