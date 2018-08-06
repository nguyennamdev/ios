//
//  PageCell.swift
//  DemoAudible
//
//  Created by Nguyen Nam on 10/17/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class BaseCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PageCell: BaseCell {
    
    var page:Page?{
        didSet{
            imageView.image = UIImage(named: (page?.imageName)!)
            let attibutedText = NSMutableAttributedString(string: (page?.title)!, attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18), NSForegroundColorAttributeName:UIColor(white: 0.2, alpha: 0.5)])
            
            attibutedText.append(NSAttributedString(string: "\n\n \((page?.message)!)", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName:UIColor(white: 0.2, alpha: 0.5)]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attibutedText.string.characters.count
            attibutedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
            textView.attributedText = attibutedText
        }
    }
    
    
    private let imageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        image.clipsToBounds = true
        return image
    }()
    
    private let textView:UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.text = "SAMPLE TEXT FOR NOW"
        tv.backgroundColor = UIColor.white
        tv.textAlignment = .center
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    override func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        backgroundColor = UIColor.white
        
        
        textView.anchorWithConstants(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        textView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        
        imageView.anchorWithConstants(top: self.topAnchor, left: self.leftAnchor, bottom: textView.topAnchor, right: self.rightAnchor)
    }
}







