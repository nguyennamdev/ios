//
//  Shape.swift
//  DemoShapeProtocol
//
//  Created by Nguyen Nam on 7/4/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation

protocol Shape{
    var name:String {set get}
    func area() -> Double
    func circuit() -> Double
}

class Circle: Shape {
    var radius:Double
    var name: String
    
    init(_ name:String, _ radius:Double) {
        self.name = name
        self.radius = radius
    }
    
    func circuit() -> Double {
        return Double.pi * (2*radius)
    }
    func area() -> Double {
        return Double.pi * (radius * radius)
    }
}


class Rectan : Shape{
    var nameShape:String
    var width:Double
    var height:Double
    
    init(name nameShape:String, _ width:Double, _ height:Double) {
        self.nameShape = nameShape
        self.width = width
        self.height = height
    }
    
    func circuit() -> Double {
        return (width + height) / 2
    }
    
    func area() -> Double {
        return width * height
    }
    
    var name: String
    {
        set{
            nameShape = newValue
        }
        get{
            return nameShape
        }
    }
}
