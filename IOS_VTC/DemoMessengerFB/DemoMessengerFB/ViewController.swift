//
//  ViewController.swift
//  DemoMessengerFB
//
//  Created by Nguyen Nam on 9/18/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class FriendsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var messages:[Message]?
    private let cellId = "messageCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        
//        messages = messages?.sorted(by: { $0.date?.compare($1.date! as Date) == .orderedDescending
//        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        cell.message = messages?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.friend = messages?[indexPath.item].friend
        self.navigationController?.pushViewController(chatLogController, animated: false)
    }
}


class BaseCell:UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        
    }
    
}

