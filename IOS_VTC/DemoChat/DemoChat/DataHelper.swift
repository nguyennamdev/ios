//
//  DataHolder.swift
//  DemoChat
//
//  Created by Nguyen Nam on 10/7/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData

extension MessageCollectionController{
    
    
    /*
    func setupData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            clearData()
            let user:User = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            user.id = "id0001"
            user.name = "Nguyen Nam"
            user.email = "namcoithang8@gmail.com"
            user.profileImageUrl = "https://scontent.fhan3-1.fna.fbcdn.net/v/t1.0-9/21369145_872781986204163_1953654055015235876_n.jpg?oh=a7f0c3554157f175883aa16f9a08b77e&oe=5A4B7E6A"
            user.isActive = true
            
            // create friend
            
            // mark zuckerberg
            let mark:Friend = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            mark.isActive = true
            mark.name = "Mark Zuckerberg"
            mark.profileImageName = "markzuckerberg"
            mark.user = user
            // steve jobs
            let stevejob:Friend = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            stevejob.isActive = true
            stevejob.name = "Steve Jobs"
            stevejob.profileImageName = "stevejob"
            stevejob.user = user
            
            // create message
            createMessageWithText(text: "Hello friend !", friend: mark, minutesAgo:1)
            createMessageWithText(text: "Do you want in join party! In party have fruits and cake , meet and music", friend: mark, minutesAgo: 2)
            
            createMessageWithText(text: "ok i will go to party . thanks !", friend: mark, minutesAgo:3,isSender: false)
            
            createMessageWithText(text: "I want to meet you !", friend: stevejob, minutesAgo: 0)
            
            do{
                try context.save()
            }catch {}
            loadData()
        }
    }*/
    
    func loadData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            var friends:[Friend] = [Friend]()
            friends = fetchFriends()!
            self.messages = [Message]()
            for friend in friends{
                let fetchMessage:NSFetchRequest<Message> = Message.fetchRequest()
                fetchMessage.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                fetchMessage.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                fetchMessage.fetchLimit = 1
                do{
                    let listMessage = try?context.fetch(fetchMessage)
                    for item in listMessage!{
                       self.messages?.append(item)
                    }
                }
            }
        }
    }
    
    func fetchFriends() -> [Friend]?{
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            let fetchFriend:NSFetchRequest<Friend> = Friend.fetchRequest()
            do{
                return try!(context.fetch(fetchFriend))
            }
        }
        return nil
    }
    
    func clearData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            let friend:NSFetchRequest<Friend> = Friend.fetchRequest()
            let friends = try!context.fetch(friend)
            for item in friends{
                context.delete(item)
            }
            let message:NSFetchRequest<Message> = Message.fetchRequest()
            let messages = try!context.fetch(message)
            for item in messages{
                context.delete(item)
            }
        }
    }
    
   static func createMessageWithText(text:String,friend:Friend,minutesAgo:Int, isSender:Bool = true) -> Message?{
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            message.text = text
            message.friend = friend
            message.date = NSDate().addingTimeInterval(TimeInterval(-minutesAgo * 60))
            message.isSender = isSender
            do{
               try?context.save()
            }
            return message
        }
        return nil
    }
    
}





