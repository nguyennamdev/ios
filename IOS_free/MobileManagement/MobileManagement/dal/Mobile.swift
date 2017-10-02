//
//  Mobile.swift
//  MobileManagement
//
//  Created by Nguyen Nam on 6/23/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation

class Mobile{
    var mID:String!
    var model:String!
    var manufacture:String!
    var configuration:String!
    var price:Double!
    var amount:Int!
    
    init(_ mID:String!,_ model:String!,_ manufacture:String!,_ configuration:String!,_ price:Double!,_ amount:Int!) {
        self.mID = mID
        self.model = model
        self.manufacture = manufacture
        self.configuration = configuration
        self.price = price
        self.amount = amount
    }
    
    init?() {
        return nil
    }
}
