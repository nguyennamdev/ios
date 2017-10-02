//
//  MobileBL.swift
//  MobileManagement
//
//  Created by Nguyen Nam on 6/23/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation

class MobileBL{
   private var mobiles:[Mobile] = [Mobile]()
    
   @discardableResult func addMobile(newMobile:Mobile) -> Bool {
        if mobiles.count == 0{
            mobiles.append(newMobile)
            return true
         }
        else{
            for item in mobiles{
                if item.mID == newMobile.mID{
                    return false
                }
                else{
                    mobiles.append(newMobile)
                    return true
                }
            }
        }
         return false
    }
    
  @discardableResult  func updateMobile(newMobile:Mobile) -> Bool {
        for item in mobiles {
            if newMobile.mID == item.mID{
                item.amount = newMobile.amount
                item.configuration = newMobile.configuration
                item.manufacture = newMobile.manufacture
                item.model = newMobile.model
                item.price = newMobile.price
                return true
            }
        }
        return false
    }
    
    @discardableResult func getAll() -> Array<Mobile> {
        var mobile:[Mobile] = [Mobile]()
        if mobiles.count != 0{
            for item in mobiles {
                mobile.append(item)
            }
             return mobile
        }
        return mobiles
    }
    
    
}
