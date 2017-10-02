//
//  ViewController.swift
//  DemoAppStore
//
//  Created by Nguyen Nam on 9/11/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class FeatuedViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{

    private let cellID = "cellID"
    
    var appCategories:[AppCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
//        AppCategory.fetchFeatureApps { (appCategories) -> () in
//            self.appCategories = appCategories
//            self.collectionView?.reloadData()
//        }
//        
        collectionView?.alwaysBounceVertical = true
        appCategories = AppCategory.sampleAppCategories()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.backgroundColor = UIColor.white
        self.collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
        self.collectionView?.isScrollEnabled = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CategoryCell
        cell?.appCategory = appCategories?[indexPath.item]
        cell?.featuredViewController = self
        return cell!
    }
    
    func showAppDetail(app:App){
        let layout = UICollectionViewFlowLayout()
        let appDetailViewController = AppDetailController(collectionViewLayout: layout)
        appDetailViewController.app = app
        navigationController?.pushViewController(appDetailViewController, animated: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    
    
    
}


