//
//  SocketHelper.swift
//  DemoChat
//
//  Created by Nguyen Nam on 10/9/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import SocketIO

class SocketIOManager: NSObject {
    private static let instance = SocketIOManager()
    
    private override init() {
        super.init()
    }
    
    public static func getIntance() -> SocketIOManager{
        return instance
    }
    
    let socket = SocketIOClient(socketURL: URL(string: "http://localhost:1997")!, config: [])
    
    public func clientConnected(){
        socket.on(clientEvent: .connect) { (data, ack) in
            
        }
    }
    
    public func clientSendMessage(data : [String: AnyObject]){
        socket.emit("client-send-message", with: [data])
    }
    
    public func connect(){
        socket.connect()
    }
    
    public func sendInforUser(data:[String:Any]){
        socket.emit("send-infor-user", with: [data])
    }
    
    public func getListUser(completionHander:@escaping ([Friend]) -> ())
    {
        var friends:[Friend] = [Friend]()
        socket.on("send-list-user-active")
        { (data, ack) in
            let array = NSArray(array: data) // array type NSArray
            array.forEach({ (item) in
                // elements type NSArray
                if let elements = item as? NSArray
                {
                    elements.forEach({ (item) in
                        if let dictionary = item as? NSDictionary
                        {
                            // get friend by dictionary
                            let delegate = UIApplication.shared.delegate as? AppDelegate
                            if let context = delegate?.persistentContainer.viewContext {
                                let friend = Friend(context: context)
                                friend.name = dictionary.value(forKey: "name") as? String
                                friend.isActive = true
                                friend.profileImageName = dictionary.value(forKey: "urlPicture") as? String
                                friends.append(friend)
                            }
                        }
                    })
                }
            })
            DispatchQueue.main.async {
                completionHander(friends)
            }
        }
    }
    
    public func getMessage(completeHander:@escaping (Message) -> ()){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            let message = Message(context: context)
            let friend = Friend(context: context)
            socket.on("server-send-message", callback: { (data, ack) in
                if let dictionary = data[0] as? NSDictionary{
                    message.date = NSDate().addingTimeInterval(TimeInterval((dictionary.value(forKey: "date") as? NSNumber)!))
                    message.text = dictionary["text"] as? String
                    message.isSender = (dictionary["isSender"] as? Bool)!
                    
                    let friendDic = dictionary["friend"] as? NSDictionary
                    friend.name = friendDic?.value(forKey: "name") as? String
                    friend.profileImageName = friendDic?.value(forKey: "profileImageName") as? String
                    friend.isActive = (friendDic?.value(forKey: "isActive") as? Bool)!
                    message.friend = friend
                }
                DispatchQueue.main.async {
                    completeHander(message)
                }
            })
            
        }
    }
}










