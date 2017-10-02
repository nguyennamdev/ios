//
//  MessageCell.swift
//  DemoMessengerFB
//
//  Created by Nguyen Nam on 9/18/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit


class MessageCell:BaseCell{
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor(red: 0, green: 134/255, blue: 249/255, alpha: 1) : UIColor.white
            nameLabel.textColor  = isHighlighted ? UIColor.white : UIColor.black
            timeLabel.textColor  = isHighlighted ? UIColor.white : UIColor.black
            messageLabel.textColor  = isHighlighted ? UIColor.white : UIColor.black
           
        }
    }
    
    var message:Message?{
        didSet{
            if let name = message?.friend?.name,
                let image = message?.friend?.profileImageName{
                nameLabel.text = name
                profileImage.image = UIImage(named: image)
                hasReadMessage.image = UIImage(named: image)
            }
            if let messageText = message?.text,
                let time = message?.date{
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "h:mm a"
                messageLabel.text = messageText
                timeLabel.text = dateFormater.string(from: time as Date )
            }
        }
    }
    
    let profileImage:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 34
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()
    
    let dividerLine:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let messageLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    let timeLabel:UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.textAlignment = .right
        return label
    }()
    
    let hasReadMessage:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    override func setupViews() {
        addSubview(profileImage)
        addSubview(dividerLine)
        
        setupContainerViews()
        
        addContraintWithFormat(format: "H:|-12-[v0(68)]", views: profileImage)
        addContraintWithFormat(format: "V:[v0(68)]", views: profileImage)
        
        addConstraint(NSLayoutConstraint(item: profileImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addContraintWithFormat(format: "H:|-90-[v0]|", views: dividerLine)
        addContraintWithFormat(format: "V:[v0(0.5)]|", views: dividerLine)
    }
    
    func setupContainerViews(){
        let containerView = UIView()
        addSubview(containerView)
        addContraintWithFormat(format: "H:|-90-[v0]|", views: containerView)
        addContraintWithFormat(format: "V:[v0(60)]", views: containerView)
        
        addConstraint(NSLayoutConstraint.init(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadMessage)
        
        
        addContraintWithFormat(format: "H:|[v0][v1(80)]-12-|", views: nameLabel,timeLabel)
        addContraintWithFormat(format: "H:|[v0]-12-[v1(20)]-12-|", views: messageLabel,hasReadMessage)
        addContraintWithFormat(format: "V:|[v0][v1]|", views: nameLabel,messageLabel)
        addContraintWithFormat(format: "V:|[v0(24)][v1(20)]-4-|", views: timeLabel,hasReadMessage)
    }
}
