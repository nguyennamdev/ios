//
//  Food.swift
//  DemoSaveDataWithSQL
//
//  Created by Nguyen Nam on 12/26/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation

public class Food{
    
    var id:Int!
    var name:String!
    var image:String? = ""
    var rate:Int!
    
    init(_ name:String, _ image:String?, _ rate:Int) {
        guard (rate >= 0) && (rate <= 5) else{
            return
        }
        self.name = name
        self.image = image
        self.rate = rate
    }
}
