//
//  UserTableViewCell.swift
//  GameOfChats
//
//  Created by Nguyen Nam on 12/29/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UserTableViewCell: UITableViewCell {
    
    var user:User?{
        didSet{
            guard let name = user?.name,let email = user?.email,let imageUrl = user?.imageUrl else {
                return
            }
            self.textLabel?.text = name
            self.detailTextLabel?.text = email
            // load image from firebase
            profileImageView.loadImageUsingCacheWithURL(urlString: imageUrl)
            timeLabel.text = ""
        }
        
    }
    
    
    var message:Message?{
        didSet{
            
            setupNameAndProfileImage()
            
            if let seconds = message?.timestamp?.doubleValue{
                let timestampDate = NSDate(timeIntervalSince1970: seconds)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                timeLabel.text = dateFormatter.string(from: timestampDate as Date)
            }
        }
    }
    
    private func setupNameAndProfileImage(){
        let chatParterId:String?
        
        if message?.fromId == Auth.auth().currentUser?.uid {
            chatParterId = message?.toId
        }else{
            chatParterId = message?.fromId
        }
        
        
        guard let id = chatParterId else {
            return
        }
        
        
        Database.database().reference().child("users").child(id).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any]{
                let user = User()
                user.setValuesForKeys(dictionary)
                self.textLabel?.text = user.name
                
                self.profileImageView.loadImageUsingCacheWithURL(urlString: user.imageUrl!)
            }
        })
        
        if let text = message?.text {
            self.detailTextLabel?.text = text
        }else{
            self.detailTextLabel?.text = "Sent an image..."
        }
        
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(profileImageView)
        addSubview(timeLabel)
        setupProfileImage()
        setupTimeLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textLabel?.frame = CGRect(x: 56, y: textLabel!.frame.origin.y, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        self.detailTextLabel?.frame = CGRect(x: 56, y: detailTextLabel!.frame.origin.y, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
        
    }
    
    private func setupProfileImage(){
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
//        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupTimeLabel(){
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
//        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    let profileImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var timeLabel:UILabel = {
        let label = UILabel()
        label.text = "HH:MM:SS"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
