//
//  ChatLogCell.swift
//  DemoChat
//
//  Created by Nguyen Nam on 10/7/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ChatLogCell: BaseCell {
    let messageText:UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.font = UIFont.systemFont(ofSize: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = UIColor.black
        text.backgroundColor = UIColor.clear
        return text
    }()
    
    let textBubbleView:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImageView:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(textBubbleView)
        addSubview(profileImageView)
        textBubbleView.addSubview(messageText)
        setConstraintView()
    }
    
    private func setConstraintView(){
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant:12).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
//        messageText.centerXAnchor.constraint(equalTo: textBubbleView.centerXAnchor).isActive = true
//        messageText.centerYAnchor.constraint(equalTo: textBubbleView.centerYAnchor).isActive = true
    }
}
