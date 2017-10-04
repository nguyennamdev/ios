//
//  MessageCollectionController.swift
//  DemoChat
//
//  Created by Nguyen Nam on 10/3/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class MessageCollectionController : UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var user:User?
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("msg did load")
        collectionView?.backgroundColor = UIColor.white
        
        //        let leftBarButtonItem = UIBarButtonItem(title: "Click", style: .plain, target: self, action: #selector(getInfoProfile))
        //        navigationController?.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(MessageHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print("msg did appear")
        guard let name = user?.name else {
            return
        }
        navigationController?.navigationBar.topItem?.title = name
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
