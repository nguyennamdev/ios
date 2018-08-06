//
//  ChatLogController.swift
//  DemoChat
//
//  Created by Nguyen Nam on 10/7/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData

class ChatLogCollectionController:UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate{
    
    
    private let cellId = "ChatLogCell"
    var friend:Friend?{
        didSet{
            messages = friend?.messages?.allObjects as? [Message]
            navigationItem.title = friend?.name
        }
    }
    
    let socket = SocketIOManager.getIntance()
    
    var messages:[Message]?
    var bottomMessageContraint:NSLayoutConstraint?
    
    let containViewInput:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let textInputTextField:UITextField = {
        let text = UITextField()
        text.placeholder = "Input your message ..."
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let sendButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "send-button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("chat log view did load")
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatLogCell.self, forCellWithReuseIdentifier: cellId)
        messages?.sort(by: { $0.date?.compare($1.date! as Date) == .orderedDescending })
        setupView()
        
        bottomMessageContraint = NSLayoutConstraint(item: containViewInput, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomMessageContraint!)
        
        collectionView?.alwaysBounceVertical = true
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotiication(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        textInputTextField.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ChatLogCell
        cell?.messageText.text = messages?[indexPath.item].text
        
        // make frame of text
        if let message = messages?[indexPath.item],
            let messageText = message.text,
            let profileImageNameURL = message.friend?.profileImageName
        {
            let size = CGSize(width: 250, height: 1000)
            // estimested
            let estimated = NSString(string: messageText).boundingRect(with: size, options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 18)], context: nil)
            
            if message.isSender{
                cell?.messageText.frame = CGRect(x: 0, y: 0, width: estimated.width + 16 , height: estimated.height + 16 + 4)
                cell?.textBubbleView.frame = CGRect(x: 50, y: 0, width: estimated.width + 16 + 8 , height: estimated.height + 16)
                
            }
            else{
                cell?.messageText.frame = CGRect(x: 0, y: 0, width: estimated.width + 16 , height: estimated.height + 16 + 4)
                cell?.textBubbleView.frame = CGRect(x: view.frame.width - estimated.width - 50, y: 0, width: estimated.width + 16 + 8 , height: estimated.height + 16)
                cell?.profileImageView.isHidden = true
            }
            // set image
            do{
                let data = try?Data(contentsOf: URL(string: profileImageNameURL)!)
                cell?.profileImageView.image = UIImage(data: data!)
            }            
        }
        
        return cell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let messageText = messages?[indexPath.item].text {
            let size = CGSize(width: 250, height: 1000)
            let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimated = NSString(string: messageText).boundingRect(with: size, options: option, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18)], context: nil)
            return CGSize(width: view.frame.width + 16 + 8, height: estimated.height  + 16 + 8)
        }
        return CGSize(width: view.frame.width, height: 100)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textInputTextField.resignFirstResponder()
        return true
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("chat log will apprear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("chat log did appear")
    }
    
    ////////////////// MARK : Function ///////////////////////////////
    
    func handleKeyboardNotification(notification:NSNotification){
        if let userInfo = notification.userInfo{
            // get keyboard frames
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
            print(keyboardFrame.height)
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            bottomMessageContraint?.constant = isKeyboardShowing ? -keyboardFrame.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                //                if let item = self.messages?.count {
                //                    let indexPath = NSIndexPath(item: item - 1, section: 0)
                //                    self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.bottom, animated: true)
                //                }
                
            })
        }
        
    }
    
    func setupView(){
        view.addSubview(containViewInput)
        containViewInput.addSubview(textInputTextField)
        containViewInput.addSubview(sendButton)
        
        let dividerTop:UIView = UIView()
        view.addSubview(dividerTop)
        dividerTop.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        dividerTop.translatesAutoresizingMaskIntoConstraints = false
        
        containViewInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        containViewInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //        containViewInput.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        sendButton.rightAnchor.constraint(equalTo: containViewInput.rightAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containViewInput.heightAnchor, multiplier: 1).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containViewInput.centerYAnchor).isActive = true
        
        textInputTextField.leftAnchor.constraint(equalTo: containViewInput.leftAnchor).isActive = true
        textInputTextField.centerYAnchor.constraint(equalTo: containViewInput.centerYAnchor).isActive = true
        textInputTextField.widthAnchor.constraint(equalTo: containViewInput.widthAnchor, multiplier: 1, constant: 50).isActive = true
        textInputTextField.heightAnchor.constraint(equalTo: containViewInput.heightAnchor, multiplier: 1).isActive = true
        
        dividerTop.bottomAnchor.constraint(equalTo: containViewInput.topAnchor).isActive = true
        dividerTop.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        dividerTop.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    
    func handleSendMessage(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if  let context = delegate?.persistentContainer.viewContext,
            let text = textInputTextField.text
        {
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as? Message
            message?.text = text
            message?.friend = self.friend
            message?.isSender = false
            message?.date = NSDate().addingTimeInterval(TimeInterval(0))
            
            var friendDic = Dictionary<String, Any>()
            friendDic["isActive"] = message?.friend?.isActive
            friendDic["name"] = message?.friend?.name
            friendDic["profileImageName"] = message?.friend?.profileImageName
            
            socket.clientSendMessage(data: ["text": message?.text as AnyObject , "friend": friendDic as AnyObject , "isSender" : message?.isSender as AnyObject , "date" :0 as AnyObject])
            
            
            socket.getMessage(completeHander: { (message) in
                
                do{
                    try!context.save()
                    self.messages?.append(message)
                    //                messages?.append(message!)
                    let item = (self.messages?.count)! - 1
                    let indexPath = NSIndexPath(item: item, section: 0)
                    self.collectionView?.insertItems(at: [indexPath as IndexPath])
                    self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.bottom, animated: true)
                    self.textInputTextField.text = nil
                }
            })
        }
    }
    
    
}
