//
//  Currently.swift
//  DemoWeather
//
//  Created by Nguyen Nam on 8/30/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation

class Currently{
    var address:Address?
    var time:Int?
    var summary:String?
    var icon:String?
    var temperature:Double?
    var humidity:Double?
    var windSpeed:Double?
    var cloudCover:Double?
//    
//    public func setValueByDictionary(_ dictionary:NSDictionary){
//        self.time = dictionary.value(forKeyPath: "currently.time") as? String
//        self.summary = dictionary.value(forKeyPath: "currently.summary") as? String
//        self.icon =  dictionary.value(forKeyPath: "currently.icon") as? String
//        self.temperature = dictionary.value(forKeyPath: "currently.temperature") as? Double
//        self.humidity = dictionary.value(forKeyPath: "currently.humidity") as? Double
//        self.windSpeed = dictionary.value(forKeyPath: "currently.windSpeed") as? Double
//        self.cloudCover = dictionary.value(forKeyPath: "currently.cloudCover") as? Double
//    }
}
class Address{
    var city:String?
    var country:String?
}
