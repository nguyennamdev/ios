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

class MessageHeader:BaseCell , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "cellId"
    
    let friendsActive:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
//    let label:UILabel = {
//        let label = UILabel()
//        label.text = "Những bạn đang online"
//        label.textAlignment = .left
//        label.textColor = UIColor.black
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.blue
//        addSubview(friendsActive)
        
        let viewww = UIView()
        addSubview(viewww)
        viewww.backgroundColor = UIColor.cyan
        viewww.translatesAutoresizingMaskIntoConstraints = false
        viewww.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        viewww.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        viewww.widthAnchor.constraint(equalToConstant: 50).isActive = true
        viewww.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        friendsActive.delegate = self
        friendsActive.dataSource = self
        
    }
    
//    func setupConstraintLayout(){
//        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
//        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
//        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height - 20)
    }
    
    
}

class MessageCell: BaseCell {
    override func setupView() {
        super.setupView()
        
        backgroundColor = UIColor.gray
    }
}
