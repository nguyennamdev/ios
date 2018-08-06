//
//  OtherViewController.swift
//  NewFeedFacebook
//
//  Created by Nguyen Nam on 8/24/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation
import UIKit



let cellID = "friendCell"
class FriendRequestsController: UITableViewController {
    
    let sectionList:[String] = ["Friends request","Friend you maybe know"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! FriendCell
//        cell.profileImage.image = UIImage(named: (post?.profileImage)!)
        cell.nameLabel.text = "Markzukerberg"
        cell.profileImage.image = UIImage(named: "markzuckerberg")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section]
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }



}
class FriendCell: UITableViewCell {
    
   public var profileImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
   public var nameLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
   public let confirmButton:UIButton = FriendCell.setTitleForButton(title: "Confirm", color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    
   public let deleteButton:UIButton = FriendCell.setTitleForButton(title: "Delete", color: UIColor.darkGray)
    
   static func setTitleForButton(title:String,color:UIColor ) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 5
        return button
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupViews()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupViews(){
        //add views
        addSubview(profileImage)
        addSubview(nameLabel)
        addSubview(confirmButton)
        addSubview(deleteButton)
        
        // constraint
        addConstraintsWithFormat(format: "H:|[v0(50)]-5-[v1]|", views: profileImage,nameLabel)
        addConstraintsWithFormat(format: "H:|[v0]-5-[v1(80)]-10-[v2(80)]", views: profileImage,confirmButton,deleteButton)
        addConstraintsWithFormat(format: "V:|-5-[v0(50)]-5-|", views: profileImage)
        addConstraintsWithFormat(format: "V:|-5-[v0][v1]", views: nameLabel,confirmButton)
        addConstraintsWithFormat(format: "V:|-5-[v0][v1]", views: nameLabel,deleteButton)
        
    }
}
