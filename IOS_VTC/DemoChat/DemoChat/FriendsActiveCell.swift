//
//  MessageHeader.swift
//  DemoChat
//
//  Created by Nguyen Nam on 10/4/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class FriendActiveCell: BaseCell {
    var friend:Friend?{
        didSet{
            guard let name = friend?.name,
                let imageUrl = friend?.profileImageName
                else {
                    return
            }
            friendName.text = name
            do{
                let data = try?Data(contentsOf: URL(string: imageUrl)!)
                friendImage.image = UIImage(data: data!)
            }
        }
    }
    
    let friendImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = UIColor.brown
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let friendName:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(friendName)
        addSubview(friendImage)
        friendImage.topAnchor.constraint(equalTo: self.topAnchor, constant:8).isActive = true
        friendImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        friendImage.widthAnchor.constraint(equalToConstant: 65).isActive = true
        friendImage.heightAnchor.constraint(equalToConstant: 65).isActive = true
        friendImage.layer.cornerRadius = 32.5
        friendName.topAnchor.constraint(equalTo: friendImage.bottomAnchor).isActive = true
        friendName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    
    
}


