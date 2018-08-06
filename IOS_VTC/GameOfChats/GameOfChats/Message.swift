//
//  Message.swift
//  GameOfChats
//
//  Created by Nguyen Nam on 1/2/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit
import FirebaseAuth

class Message : NSObject{
    
    var fromId:String?
    var toId:String?
    var text:String?
    var timestamp:NSNumber?
    var imageUrl:String?
    var imageWidth:NSNumber?
    var imageHeight:NSNumber?
    var videoUrl:String?

    func chatParterId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
}
