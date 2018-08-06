//
//  Post.swift
//  NewFeedFacebook
//
//  Created by Nguyen Nam on 8/21/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation

class Post{
    var name:String?
    var status:String?
    var profileImage:String?
    var statusImage:String?
    var numLikes:String?
    var numComments:String?
    var statusImageUrl:String?
    
    func setValuesForKeyWithDictionary(dictionary:[String:AnyObject]){
        self.name = dictionary["name"] as? String
        self.status = dictionary["status"] as? String
        self.profileImage = dictionary["profileImage"] as? String
        self.statusImage = dictionary["statusImage"] as? String
        self.numLikes = dictionary["numLikes"] as? String
        self.numComments = dictionary["numComments"] as? String
        self.statusImageUrl = dictionary["statusImageUrl"] as? String
    }
}

class Posts{
    
//    var postList:[Post]
    
//    init(){
////        let markZuckbergPost = Post()
////        markZuckbergPost.name = "Mark Zuckberg"
////        markZuckbergPost.status = "Hello World!"
////        markZuckbergPost.profileImage = "markzuckerberg"
////        markZuckbergPost.statusImage = "apple"
////        markZuckbergPost.numLikes =  Int.convertToThousand(number: 120000)
////        markZuckbergPost.numComments = Int.convertToThousand(number: 123)
////        markZuckbergPost.statusImageUrl = "https://scontent.fsgn2-2.fna.fbcdn.net/v/t1.0-9/20246455_849379035211125_2563071567637698968_n.jpg?oh=00dce62a69e3f4448a8dc6e90fa922db&oe=5A3198B5"
////        
////        
////        let steveJobPost  = Post()
////        steveJobPost.name = "Steve Jobs"
////        steveJobPost.status = "............................................................................." +
////        "....................................................................................................................................................................................................................................................................................................................................................................................."
////        steveJobPost.profileImage = "stevejob"
////        steveJobPost.statusImage = "cho"
////        steveJobPost.numLikes = Int.convertToThousand(number: 41313)
////        steveJobPost.numComments = Int.convertToThousand(number: 3213)
////        steveJobPost.statusImageUrl = "https://scontent.fsgn2-2.fna.fbcdn.net/v/t1.0-9/18486291_812888802193482_2182405633802316875_n.jpg?oh=c6d677ff56f1440354087f274ce4c2f4&oe=5A1D971B"
////        
////        postList = [Post]()
////        postList.append(markZuckbergPost)
////        postList.append(steveJobPost)
//       
//    }
    
}
