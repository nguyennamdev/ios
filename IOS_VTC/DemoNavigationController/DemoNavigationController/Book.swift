//
//  Book.swift
//  DemoNavigationController
//
//  Created by Nguyen Nam on 8/2/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation

class Book: NSObject {
    var title:String
    var author:String
    
    override init() {
        title = ""
        author = ""
    }
    
    init(_ title:String, _ author:String) {
        self.title = title
        self.author = author
    }
}
