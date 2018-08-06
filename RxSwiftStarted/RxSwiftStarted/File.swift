
//
//  File.swift
//  RxSwiftStarted
//
//  Created by Nguyen Nam on 1/23/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class CircleViewModel {
    
    var centerVariable = Variable<CGPoint?>(.zero) // create one variable that will be changed and observed
    var backgroundColorObservable:Observable<UIColor>! // create observable that will change backgound color base on center
    
    init() {
        setup()
    }
    
    func setup(){
        // When we get new center, emit new UIColor 
        backgroundColorObservable = centerVariable.asObservable().map({ (center)  in
            guard let center = center else{
                return UIColor.flatten(.blue)()
            }
            
            let red:CGFloat = ((center.x + center.y)) / 255 //
            let green:CGFloat = 0
            let blue:CGFloat = 0
            return UIColor.blue
        })
    }

}
