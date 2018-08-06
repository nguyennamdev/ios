//
//  CategoryCell.swift
//  DemoAppStore
//
//  Created by Nguyen Nam on 9/11/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class CategoryCell:UICollectionViewCell , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let appCellID = "appCellId"
    var featuredViewController:FeatuedViewController?
    
    var appCategory:AppCategory?{
        didSet{
            if let name = appCategory?.name{
                nameLabel.text = name
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let appsCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let nameLabel:UILabel = {
        let label  = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let dividerLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews(){
        backgroundColor = UIColor.clear
        addSubview(appsCollectionView)
        addSubview(dividerLine)
        addSubview(nameLabel)
        
        
        appsCollectionView.dataSource = self
        appsCollectionView.delegate = self
        
        
        appsCollectionView.register(AppCell.self, forCellWithReuseIdentifier: appCellID)
        
        addContraintWithFormat(stringFormat: "H:|-14-[v0]|", views: nameLabel)
        addContraintWithFormat(stringFormat: "H:|-14-[v0]|", views: dividerLine)
        addContraintWithFormat(stringFormat: "H:|[v0]|", views: appsCollectionView)
        addContraintWithFormat(stringFormat: "V:|[v0]-5-[v1][v2(0.5)]|", views: nameLabel,appsCollectionView,dividerLine)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (appCategory?.apps?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appCellID, for: indexPath) as? AppCell
        cell?.app = appCategory?.apps?[indexPath.item]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appCategory?.apps?[indexPath.item]{
            featuredViewController?.showAppDetail(app: app)
        }
    }
}
class AppCell: UICollectionViewCell {
    
    var app:App?{
        didSet{
            titleLabel.text = app?.name
            logoImage.image = UIImage(named: (app?.imageName)!)
            categoryLabel.text = app?.category
            if let price = app?.price{
                priceLabel.text = "$\(price)"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let logoImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    
    func setupViews(){
        addSubview(logoImage)
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        
        logoImage.frame = CGRect(x: 0, y: 15, width: frame.width, height: frame.width)
        titleLabel.frame = CGRect(x: 0, y: frame.width + 17, width: frame.width, height: 20)
        categoryLabel.frame = CGRect(x: 0, y: frame.width + 35, width: frame.width, height: 20)
        priceLabel.frame = CGRect(x: 0, y: frame.width + 57, width: frame.width, height: 10)
        
    }
}





