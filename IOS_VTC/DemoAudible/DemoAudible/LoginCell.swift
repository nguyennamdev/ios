//
//  LoginCell.swift
//  DemoAudible
//
//  Created by Nguyen Nam on 10/18/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class LoginCell:BaseCell{
    
    let logoImageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "icon")
        return image
    }()
    
    let emailTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var loginButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Login", for:.normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handlerLogin), for: .touchUpInside)
        return button
    }()
    
    weak var loginDelegate:LoginControllerDelegate?
    
    func handlerLogin()  {
        loginDelegate?.finishIsLogin()
    }
    
    override func setupViews() {
        backgroundColor = UIColor.white
        // MARK : Add subview
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passTextField)
        addSubview(loginButton)
        // MARK : view add constaint
        logoImageView.anchorWithConstants(top: centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -200, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        logoImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        emailTextField.anchorWithConstants(top: logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 32, bottomConstant: 0, rightConstant: 32)
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passTextField.anchorWithConstants(top: emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 32, bottomConstant:0, rightConstant: 32)
        passTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        loginButton.anchorWithWidthHeightConstant(top: passTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant:50)
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
