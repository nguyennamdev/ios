//
//  ViewController.swift
//  GameOfChats
//
//  Created by Nguyen Nam on 12/17/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class MessagesController: UITableViewController {
    
    var ref:DatabaseReference!
    let cellId = "cellId"
    var messages = [Message]()
    var messageDictionary = [String:Message]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        ref = Database.database().reference()
        self.tableView.register(UserTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    //MARK: private method
    
    
    private func observerUserMessages(){
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        ref.child("user-posts").child(uid).observe(.childAdded, with: { (snapshot) in
            
            let toId = snapshot.key
            Database.database().reference().child("user-posts").child(uid).child(toId).observe(.childAdded, with: { (snapshot) in
                // get message id 
                let messageId = snapshot.key
                // make ref to message by message id
                let messageRef = Database.database().reference().child("posts").child(messageId)
                messageRef.observeSingleEvent(of: .value, with: { (messageSnapshot) in
                    if let dictionary = messageSnapshot.value as? [String:Any] {
                        let message = Message()
                        message.setValuesForKeys(dictionary)
                        // set  row once for a person
                        if let toId = message.chatParterId(){
                            self.messageDictionary[toId] = message
                            self.messages = Array(self.messageDictionary.values)
                            self.messages.sort(by: { (m1, m2) -> Bool in
                                return (m1.timestamp?.intValue)! > (m2.timestamp?.intValue)!
                            })
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }, withCancel: nil)
                
            })
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // user is not logged in
        checkIfUserIsLoggedIn()
    }
    
    private func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil{
            handleLogout()
        }else{
            guard  let uid = Auth.auth().currentUser?.uid else {
                return
            }
            ref.child("users").child(uid).observe(.value, with: { (snapshot) in
                // Get user value
                let values = snapshot.value as? [String:Any]
                let user = User()
                user.setValuesForKeys(values!)
                self.setupNavBarWithUser(user: user)
            })
        }
    }
    
    private func setupNavBarWithUser(user:User){
        self.messages.removeAll()
        self.messageDictionary.removeAll()
        self.tableView.reloadData()
        
        observerUserMessages()
        
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        guard let profileImageURL = user.imageUrl else {
            return
        }
        // create sub title view profile image
        
        let profileImageTitleView = UIImageView()
        titleView.addSubview(profileImageTitleView)
        // setup profile image title view
        
        profileImageTitleView.loadImageUsingCacheWithURL(urlString: profileImageURL)
        profileImageTitleView.translatesAutoresizingMaskIntoConstraints = false
        profileImageTitleView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        profileImageTitleView.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true
        profileImageTitleView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageTitleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageTitleView.layer.cornerRadius = 20
        profileImageTitleView.layer.borderWidth = 1
        profileImageTitleView.layer.borderColor = UIColor.gray.cgColor
        
        // name label subview of title view
        
        let nameLabelTitleView = UILabel()
        nameLabelTitleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(nameLabelTitleView)
        // setup name label title view
        nameLabelTitleView.leftAnchor.constraint(equalTo: profileImageTitleView.rightAnchor, constant: 2).isActive = true
        nameLabelTitleView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        nameLabelTitleView.text = user.name
        self.navigationItem.titleView = titleView
        //        //        self.navigationItem.title = user.name
        //        titleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatLog)))
        //
        
    }
    
    @IBAction func handleNewMessage(_ sender: Any) {
        
        let newMessageController = NewMessageController()
        newMessageController.messageController = self
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
        
    }
    
    @objc private func handleLogout(){
        do{
            try Auth.auth().signOut()
        }catch let err{
            print(err)
        }
        let loginViewController = LoginViewController()
        present(loginViewController, animated: true, completion: nil)
    }
    
    // MARK : public method
    
    @objc public func showChatLogWithUser(user:User){
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.user = user
        self.navigationController?.pushViewController(chatLogController, animated: true)
        
    }
    
}

// set up table view

extension MessagesController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UserTableViewCell
        cell?.message = messages[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

// delegate of table view

extension MessagesController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        
        guard let chatParterId = message.chatParterId() else {
            return
        }
        
        let ref = Database.database().reference().child("users").child(chatParterId)
        ref.observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:Any]{
                let user = User()
                user.id = chatParterId
                user.setValuesForKeys(dictionary)
                self.showChatLogWithUser(user: user)
            }
        })
    }
}
