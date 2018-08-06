//
//  CollectionViewCell.swift
//  NewFeedFacebook
//
//  Created by Nguyen Nam on 8/21/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation
import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

class FeedCollectionViewCell: UICollectionViewCell {
    
    
    var feedController:FeedCollectionViewController?
    
    func animation(){
        feedController?.animationImageView(statusImageView: statusImageView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animation)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var post:Post? {
        didSet{
            
            statusImageView.image = nil
            activityLoader.startAnimating()
            
            if let statusImageUrl = post?.statusImageUrl{
                
                if let image = imageCache.object(forKey: statusImageUrl as AnyObject){
                    statusImageView.image = (image as! UIImage)
                }
                else{
                    URLSession.shared.dataTask(with: URL(string: statusImageUrl)!, completionHandler: { (data, response, error) in
                        
                        if error != nil{
                            return
                        }
                        
                        let image = UIImage(data: data!)
                        imageCache.setObject(image!, forKey: statusImageUrl as AnyObject)
                        self.statusImageView.image = image
                        self.activityLoader.stopAnimating()
                    }).resume()
                    
                }
                
            }
            
            setupNameLocationProfile()
        }
    }
    
    private func setupNameLocationProfile(){
        if let name = post?.name{
            // mutable attribute string
            let attributeText = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14)])
            attributeText.append(NSAttributedString(string: "\nAugust 26  - Ha Noi ", attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 12), NSForegroundColorAttributeName : UIColor.gray]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            
            attributeText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: attributeText.string.characters.count))
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "world")
            attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
            attributeText.append(NSAttributedString(attachment: attachment))
            nameLabel.attributedText = attributeText
        }
        
        if let status = post?.status{
            statusTextView.text = status
        }
        if let profileImageName = post?.profileImage{
            profileImageView.image = UIImage(named: profileImageName)
        }
        if let likes = post?.numLikes, let comments = post?.numComments {
            let attributeText = NSMutableAttributedString(string: likes + " likes ", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.gray])
            attributeText.append(NSAttributedString(string:comments + " comments", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName:UIColor.gray]))
            likesCommentsLabels.attributedText = attributeText
        }
    }
    
    // create view
    let nameLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.bounds = CGRect(x: 0, y: 0, width: 44, height: 44)
        return imageView
    }()
    
    let statusTextView:UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        return textView
    }()
    
    let statusImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    let likesCommentsLabels:UILabel = {
        let label = UILabel()
        return label
    }()
    
    let dividerLineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    let likeButton:UIButton = FeedCollectionViewCell.buttonForTitle(title: "Like", imageName: "like")
    let commentButton:UIButton = FeedCollectionViewCell.buttonForTitle(title: "Comment", imageName: "comment")
    let shareButton:UIButton = FeedCollectionViewCell.buttonForTitle(title: "Share", imageName: "share")
    
    
    let activityLoader:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = UIColor.black
        return activity
    }()
    
    private static func buttonForTitle(title:String, imageName:String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(named: imageName)?.resizeImage(newSize: CGSize(width: 20, height: 20)), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }
    
    private func setupViews(){
        backgroundColor = UIColor.white
        // add subview
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabels)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        addSubview(activityLoader)
        // add constrant for view
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView,nameLabel)
        
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        
        addConstraintsWithFormat(format: "H:|[v0(v1)]|", views: statusImageView,activityLoader)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]", views: likesCommentsLabels)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        
        addConstraintsWithFormat(format: "H:|[v0(v1)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.5)][v5(44)]|", views: profileImageView,statusTextView, statusImageView,likesCommentsLabels, dividerLineView, likeButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        addConstraintsWithFormat(format: "V:|[v0]|", views: activityLoader)
        
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(44)]-8-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView, "v1" : nameLabel]))
        //
        
    }
}
