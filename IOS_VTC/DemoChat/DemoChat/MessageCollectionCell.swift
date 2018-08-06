//
//  MessageCollectionCell.swift
//  DemoChat
//
//  Created by Nguyen Nam on 10/4/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class BaseCell:UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
    }
}

class MessageCell: BaseCell {
    var message:Message?{
        didSet{
            guard let friend = message?.friend,
                let text = message?.text,
                let time = message?.date,
                let _ = message?.isSender
                else {
                    return
            }
            guard let name = friend.name,
                let image = friend.profileImageName
                else {
                    return
            }
            friendName.text = name
            friendImage.image = UIImage(named: image)
            messageLabel.text = text
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "h:mm a"
            timeLabel.text = dateFormater.string(from: time as Date)
        }
    }
    
    let friendImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = UIColor.orange
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let containView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let friendName:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    override func setupView() {
        super.setupView()
        // add view
        addSubview(friendImage)
        addSubview(containView)
        containView.addSubview(friendName)
        containView.addSubview(messageLabel)
        containView.addSubview(timeLabel)
        setContraintLayout()
    }
    
    func setContraintLayout(){
        friendImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        friendImage.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 12).isActive = true
        friendImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        friendImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        friendImage.layer.cornerRadius = 30
        
        // constraint of contain view
        containView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containView.leftAnchor.constraint(equalTo: friendImage.rightAnchor, constant: 12).isActive = true
        containView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        containView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // constraint of friend name
        friendName.topAnchor.constraint(equalTo: containView.topAnchor, constant: 4).isActive = true
        friendName.leftAnchor.constraint(equalTo: containView.leftAnchor, constant: 8).isActive = true
        // constraint of message
        messageLabel.bottomAnchor.constraint(equalTo: containView.bottomAnchor, constant: -8).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: containView.leftAnchor, constant: 8).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: containView.rightAnchor, constant: -20).isActive = true
        // constraint of time
        timeLabel.topAnchor.constraint(equalTo: containView.topAnchor, constant: 4).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: containView.rightAnchor, constant: -8).isActive = true
        
    }
    
    
}













