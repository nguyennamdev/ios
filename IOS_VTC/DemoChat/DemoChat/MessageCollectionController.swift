//
//  MessageCollectionController.swift
//  DemoChat
//
//  Created by Nguyen Nam on 10/3/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData


class MessageCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var user:User?
    let cellId = "cellId"
    let friendActiveCell = "friendCellId"
    
    var friends:[Friend]?
    
    var messages:[Message]?
    
    var chatLogController:ChatLogCollectionController?
    
    let friendsActiveCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.tag = 0
        collection.backgroundColor = UIColor.white
        return collection
    }()
    
    let dividerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let messageCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.white
        collection.tag = 1
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("msg did load")
        friendsActiveCollection.register(FriendActiveCell.self, forCellWithReuseIdentifier: friendActiveCell)
        messageCollection.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        friendsActiveCollection.dataSource = self
        friendsActiveCollection.delegate = self
        messageCollection.delegate = self
        messageCollection.dataSource = self
        messageCollection.alwaysBounceVertical = true
        view.addSubview(messageCollection)
        view.addSubview(friendsActiveCollection)
        view.addSubview(dividerView)
        setupViews()
        view.backgroundColor = UIColor.white
        
    }
    
    func setupViews(){
        friendsActiveCollection.topAnchor.constraint(equalTo: view.topAnchor, constant:80).isActive = true
        friendsActiveCollection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        friendsActiveCollection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        friendsActiveCollection.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        dividerView.topAnchor.constraint(equalTo: friendsActiveCollection.bottomAnchor).isActive = true
        dividerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dividerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        messageCollection.topAnchor.constraint(equalTo: friendsActiveCollection.bottomAnchor).isActive = true
        messageCollection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        messageCollection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        messageCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag  {
        case 0:
            return friends?.count ?? 0
        case 1:
            return messages?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag{
        case 0:
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: friendActiveCell , for: indexPath) as! FriendActiveCell
            cell.friend = friends?[indexPath.item]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
            cell.message = messages?[indexPath.item]
            return cell
        default:
            print("don't have cell")
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: friendsActiveCollection.frame.height, height: friendsActiveCollection.frame.height)
        case 1:
            return CGSize(width: view.frame.width, height: 100)
        default:
            return CGSize()
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        self.messageCollection.collectionViewLayout.invalidateLayout()
        self.friendsActiveCollection.collectionViewLayout.invalidateLayout()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chatLogController = ChatLogCollectionController(collectionViewLayout: UICollectionViewFlowLayout())
        switch collectionView.tag {
        case 0:
            if let friend = friends?[indexPath.item]{
                chatLogController?.friend = friend
                let message = MessageCollectionController.createMessageWithText(text: "Hello honey 😍", friend: friend, minutesAgo: 0, isSender: true)
                friend.messages?.adding(message!)
                if let messages = friend.messages?.allObjects as? [Message]{
                    chatLogController?.messages = messages
                }
            }
        case 1:
            if let friend = messages?[indexPath.item].friend{
                chatLogController?.friend = friend
            }
        default:
            print("did't select")
        }
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.pushViewController(chatLogController!, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("msg did appear")
        guard let name = user?.name else {
            return
        }
        navigationController?.navigationBar.topItem?.title = name
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("mgs will dis")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("mgs did dis")
    }
    
    
}








