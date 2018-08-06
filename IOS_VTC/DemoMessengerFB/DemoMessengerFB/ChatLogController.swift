//
//  ChatLogController.swift
//  DemoMessengerFB
//
//  Created by Nguyen Nam on 9/19/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout , UITextFieldDelegate{
    
    private let cellId = "chatCell"
    var friend:Friend?{
        didSet{
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [Message]
        }
    }
    
    
    
    
    var bottonMessageContraint:NSLayoutConstraint?
    
    var messages:[Message]?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        tabBarController?.tabBar.isHidden = true
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView?.register(ChatCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(messageInputContainer)
        view.addContraintWithFormat(format: "H:|[v0]|", views: messageInputContainer)
        view.addContraintWithFormat(format: "V:[v0(40)]", views: messageInputContainer)
        setupInputComponents()
        
        bottonMessageContraint = NSLayoutConstraint(item: messageInputContainer, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        
        view.addConstraint(bottonMessageContraint!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification) , name: NSNotification.Name.UIKeyboardWillShow, object:  nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        messageInputTextField.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageInputTextField.resignFirstResponder()
        return true
    }
    
    private func setupInputComponents(){
        messageInputContainer.addSubview(messageInputTextField)
        messageInputContainer.addSubview(sendButton)
        let topBoderContainer:UIView = UIView()
        topBoderContainer.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        
        /// Contraints
        messageInputContainer.addContraintWithFormat(format: "H:|-8-[v0][v1(60)]|", views: messageInputTextField,sendButton)
        messageInputContainer.addContraintWithFormat(format: "V:|[v0]|", views: messageInputTextField)
        messageInputContainer.addContraintWithFormat(format: "V:|[v0]|", views: sendButton)
        
        messageInputContainer.addSubview(topBoderContainer)
        messageInputContainer.addContraintWithFormat(format: "H:|[v0]|", views: topBoderContainer)
        messageInputContainer.addContraintWithFormat(format: "V:|[v0(0.5)]", views: topBoderContainer)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        messageInputTextField.endEditing(true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend?.messages?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatCell
        
        cell.messageTextView.text = messages?[indexPath.item].text
        
        if  let message = messages?[indexPath.item], let messageText = message.text ,
            let profileImage = message.friend?.profileImageName{
            
            let size = CGSize(width: 250, height: 1000)
            let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimated = NSString(string: messageText).boundingRect(with: size, options: option, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18)], context: nil)
            
            // set frame estimed of messageTextView and textBubble
            if !message.isSender{
                cell.messageTextView.frame = CGRect(x: 48 + 8, y: 0, width: estimated.width  + 16, height: estimated.height + 16)
                cell.textBubble.frame = CGRect(x: 48, y: 0, width: estimated.width + 8 + 16, height: estimated.height + 16)
                cell.profileImageName.isHidden = false
            }
            else{
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimated.width - 16 - 8, y: 0, width: estimated.width  + 16, height: estimated.height + 16)
                cell.textBubble.frame = CGRect(x: view.frame.width - estimated.width - 16 - 8 - 8, y: 0, width: estimated.width + 8 + 16, height: estimated.height + 16)
                cell.profileImageName.isHidden = true
                cell.textBubble.backgroundColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
                cell.messageTextView.textColor = UIColor.white
            }
            cell.profileImageName.image = UIImage(named: profileImage)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // make frame of message
        if let messageText = messages?[indexPath.item].text {
            let size = CGSize(width: 250, height: 1000)
            let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimated = NSString(string: messageText).boundingRect(with: size, options: option, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18)], context: nil)
            return CGSize(width: view.frame.width + 16, height: estimated.height  + 20)
        }
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    
    func handleKeyboardNotification(notification:NSNotification){
        if let userInfo = notification.userInfo{
            // get keyboard frames
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
            print(keyboardFrame.height)
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            bottonMessageContraint?.constant = isKeyboardShowing ? -keyboardFrame.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                let indexPath = NSIndexPath(item: (self.messages?.count)! - 1, section: 0)
                self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.bottom, animated: true)
            })
        }
    }
    
    
    @objc private func handleSend(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            let message = FriendsController.createMessageWithTextHaveReturn(text: messageInputTextField.text!, friend: friend!, minutesAgo: 0, context: context, isSender: true)
            do{
                try context.save()
                messages?.append(message)
                messages = messages?.sorted(by: { $0.date?.compare($1.date! as Date) == .orderedAscending
                })
                
                let item = (messages?.count)! - 1
                let insertionIndexPath = NSIndexPath(item: item, section: 0)
                collectionView?.insertItems(at: [insertionIndexPath as IndexPath])
                collectionView?.scrollToItem(at: insertionIndexPath as IndexPath, at: .bottom, animated: true)
                messageInputTextField.text = nil
                
            }catch let error {
                print(error)
            }
        }
        
    }
    
    
    let messageInputTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Input your message ..."
        return textField
    }()
    
    let sendButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    
    let messageInputContainer:UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        return view
    }()
    
}
class ChatCell:BaseCell{
    
    
    let messageTextView:UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Sample message"
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    
    let textBubble:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 1)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let profileImageName:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    override func setupViews() {
        super.setupViews()
        
        addSubview(textBubble)
        addSubview(messageTextView)
        addSubview(profileImageName)
        addContraintWithFormat(format: "H:|-12-[v0(30)]", views: profileImageName)
        addContraintWithFormat(format: "V:[v0(30)]|", views: profileImageName)
        
    }
    
    
}
