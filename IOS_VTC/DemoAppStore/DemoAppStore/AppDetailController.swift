//
//  AppDetailController.swift
//  DemoAppStore
//
//  Created by Nguyen Nam on 9/14/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    private let headerId = "appDetailHeader"
    private let cellId = "appDetailCell"
    var app:App?{
        didSet{
//                navigationController = nil
                
                if let id = app?.id{
                let urlString = "https://api.letsbuildthatapp.com/appstore/appdetail?id=\(id)"
                URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) in
                    if error != nil{
                        return
                    }
                    let jsonData = (try?JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                    let appDetail = App()
                    if let dictionary = jsonData as? [String:AnyObject]{
                        appDetail.id = dictionary["Id"] as? NSNumber
                        appDetail.name = dictionary["Name"] as? String
                        appDetail.imageName = dictionary["ImageName"] as? String
                        appDetail.category = dictionary["Category"] as? String
                        appDetail.price = dictionary["Price"] as? NSNumber
                        appDetail.screenShots = dictionary["Screenshots"] as? [String]
                        appDetail.des = dictionary["description"] as? String
                        
                    }
                    self.app = appDetail
                    DispatchQueue.main.async(execute: {
                        self.collectionView?.reloadData()
                    })
                    
                    
                    
                }).resume()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(ScreenShotsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenShotsCell
        cell.app = self.app
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? AppDetailHeader
        header?.app = self.app
        return header!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 170
        )
    }
}

class AppDetailHeader : BaseCell{
    var app:App?{
        didSet{
            if let image = self.app?.imageName{
                imageView.image = UIImage(named: image)
            }
            if let name = self.app?.name {
                nameLabel.text = name
            }
            
            if let price = self.app?.price{
                button.setTitle("$\(price)", for: .normal)
            }
            
        }
    }
    
    let imageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let segmentControl:UISegmentedControl = {
        
        let segment = UISegmentedControl(items: ["Detail","Reviews","Related"])
        segment.tintColor = UIColor.darkGray
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let button:UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/250, alpha: 1).cgColor
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor(red: 0, green: 129/255, blue: 250/250, alpha: 1), for: .normal)
        return button
    }()
    
    let dividerLine:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }()
    
    override func setupViews() {
        addSubview(imageView)
        addSubview(segmentControl)
        addSubview(nameLabel)
        addSubview(button)
        addSubview(dividerLine)
        
        imageView.backgroundColor = UIColor.black
        addContraintWithFormat(stringFormat: "H:|-14-[v0(100)]-20-[v1]", views: imageView,nameLabel)
        addContraintWithFormat(stringFormat: "V:|-14-[v0(100)]", views: imageView)
        addContraintWithFormat(stringFormat: "V:|-14-[v0]", views: nameLabel)
        addContraintWithFormat(stringFormat: "H:|-40-[v0]-40-|", views: segmentControl)
        addContraintWithFormat(stringFormat: "V:[v0]-8-|", views: segmentControl)
        
        addContraintWithFormat(stringFormat: "H:[v0(60)]-14-|", views: button)
        addContraintWithFormat(stringFormat: "V:[v0]-56-|", views: button)
        
        addContraintWithFormat(stringFormat: "H:|-8-[v0]-8-|", views: dividerLine)
        addContraintWithFormat(stringFormat: "V:[v0(0.5)]|", views: dividerLine)
        
    }
}

class BaseCell:UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
    
    
}
