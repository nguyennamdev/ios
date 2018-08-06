//
//  TableViewCell.swift
//  PassDataInCellTableView
//
//  Created by Nguyen Nam on 1/16/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        textLabel?.text = "Lol"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(saveButton)
        addSubview(callButton)
        saveButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        callButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        callButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        callButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        callButton.leftAnchor.constraint(equalTo: saveButton.rightAnchor, constant: 20).isActive = true
    }
    
    lazy var saveButton:UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    lazy var callButton:UIButton = {
        let button = UIButton()
        button.setTitle("Call", for: .normal)
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCall), for: .touchUpInside)
        return button
    }()

    
   @objc func handleSave(){
        print("fadfaf")
    }
    
    @objc func handleCall(){
        print("fffffff")
    }
    
    
    
}
