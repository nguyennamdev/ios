//
//  User.swift
//  GameOfChats
//
//  Created by Nguyen Nam on 12/29/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class User: NSObject {
    var id:String?
    var name:String?
    var email:String?
    var imageUrl:String?
    
    
    init(id:String,name:String, email:String,imageUrl:String) {
        self.id = id
        self.name = name
        self.email = email
        self.imageUrl = imageUrl
    }
    
    override init() {
        super.init()
    }
    
}
