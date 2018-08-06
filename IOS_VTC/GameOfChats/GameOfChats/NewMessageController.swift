//
//  NewMessageTableViewController.swift
//  GameOfChats
//
//  Created by Nguyen Nam on 12/27/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import Firebase


class NewMessageController: UITableViewController {
    
    // MARK : properties
    
    var ref:DatabaseReference!
    var users:[User] = [User]()
    var messageController:MessagesController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        fetchUser()
        self.tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "cellId")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelController))
        
    }
    
    
    // MARK : private method 
    
    private func fetchUser(){
        ref.child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:Any]{
                let user = User()
                user.id = snapshot.key
                user.setValuesForKeys(dictionary)
                self.users.append(user)
                // this will cash because of background thread, so lets use dispath_asyn
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
    @IBAction func cancelHandle(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK : datasource and delegate of table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? UserTableViewCell
        cell?.user = self.users[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            print("dismiss completed")
            let user = self.users[indexPath.row]
            self.messageController?.showChatLogWithUser(user: user)
        }
    }
    
    @objc private func cancelController(){
        dismiss(animated: true, completion: nil)
    }
    
    
}
















