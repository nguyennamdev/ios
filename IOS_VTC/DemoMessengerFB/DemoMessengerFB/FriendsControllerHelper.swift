//
//  FriendsControllerHelper.swift
//  DemoMessengerFB
//
//  Created by Nguyen Nam on 9/18/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension FriendsController{
    
    
    func setupData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            
            clearData()
            
            ///// MARK ZUCKERBBERG
            let mark:Friend = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            mark.name = "Mark zuckerberg"
            mark.profileImageName = "markzuckerberg"
            let message:Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            message.friend = mark
            message.text = "Hello my name is Mark....Nice to meet you!"
            message.date = NSDate()
            mark.messages?.adding(message)
            
            createMessageWithText(text: "Facebook is social network better", friend: mark, minutesAgo: 0, context: context)
            
            ////////// STEVE JOBS
            let steve:Friend = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "stevejob"
            createMessageWithText(text: "Hello Nam !", friend: steve, minutesAgo: 4, context: context)
            createMessageWithText(text: "I want to talk with you . I will talk about your handsome :))", friend: steve, minutesAgo: 3, context: context)
            
            createMessageWithText(text: "Wow . I always welcome :v", friend: steve, minutesAgo:2, context: context, isSender: true)
            
            createMessageWithText(text: "You have a skin brown but it is so man , and you have a smile very fatal attract", friend: steve, minutesAgo: 1, context: context)
            
            /////////// DONALD TRUMP
            let donald:Friend = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            donald.name = "Donald Trump"
            donald.profileImageName = "donald_trump"
            
            createMessageWithText(text: "You're tired", friend: donald, minutesAgo: 1, context: context)
            
            do{
                try context.save()
            }catch {}
            
            //            messages = [message,messageSteve]
        }
        loadData()
    }
    
    private func createMessageWithText(text:String, friend:Friend, minutesAgo:Int,context:NSManagedObjectContext , isSender:Bool = false){
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(TimeInterval(-minutesAgo * 60) )
        message.isSender = isSender
    }
    
    static func createMessageWithTextHaveReturn(text:String, friend:Friend, minutesAgo:Int,context:NSManagedObjectContext , isSender:Bool = false) -> Message{
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(TimeInterval(-minutesAgo * 60) )
        message.isSender = isSender
        return message
    }

    
    func loadData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            
            var friends:[Friend] = [Friend]()
            friends = fetchFriends()!
            messages = [Message]()
            for friend in friends
            {
                let fetchMessage:NSFetchRequest<Message> = Message.fetchRequest()
                fetchMessage.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                // filter
                fetchMessage.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                // set limit to fetch
                fetchMessage.fetchLimit = 1
                
                do{
                    let fetchMessages = try?context.fetch(fetchMessage)
                    for item in fetchMessages! {
                       messages?.append(item)
                    }
                }
            }
        }
    }
    
    private func fetchFriends()  -> [Friend]?{
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
            do {
                let friend:NSFetchRequest<Friend> = Friend.fetchRequest()
                let friends = try? context.fetch(friend)
                for item in friends!{
                    context.delete(item)
                }
                let message:NSFetchRequest<Message> = Message.fetchRequest()
                let messages = try? context.fetch(message)
                for item in messages!{
                    context.delete(item)
                }
                
            }
        }
    }
}
