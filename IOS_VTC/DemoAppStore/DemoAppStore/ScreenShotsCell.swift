//
//  ScreenShotsCell.swift
//  DemoAppStore
//
//  Created by Nguyen Nam on 9/18/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ScreenShotsCell:BaseCell, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    private let cellId = "cellId"
    var app:App?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    let dividerLine:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }()
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
       return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(collectionView)
        addSubview(dividerLine)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ScreenShotsImageCell.self, forCellWithReuseIdentifier: cellId)
        addContraintWithFormat(stringFormat: "H:|[v0]|", views: collectionView)
        addContraintWithFormat(stringFormat: "V:|[v0]|", views: collectionView)
        addContraintWithFormat(stringFormat: "H:|-14-[v0]|", views: dividerLine)
        addContraintWithFormat(stringFormat: "V:[v0(0.5)]|", views: dividerLine)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenShots?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenShotsImageCell
        if let imageString = app?.screenShots?[indexPath.item]{
            cell.imageView.image = UIImage(named: imageString)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: frame.height - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}
class ScreenShotsImageCell: BaseCell {
    
    var imageView:UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        imageView.clipsToBounds = true
        addContraintWithFormat(stringFormat:"H:|[v0]|", views: imageView)
        addContraintWithFormat(stringFormat: "V:|[v0]|", views: imageView)
        
        
    }
}
