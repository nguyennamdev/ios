//
//  ViewController.swift
//  NewFeedFacebook
//
//  Created by Nguyen Nam on 8/15/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"


class FeedCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts:[Post]?
    var listPost:Posts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOvarewWillAppear = false
        posts = [Post]()
        self.collectionView?.alwaysBounceVertical = true // alway allow scroll vertical
        
        // Register cell classes
        self.collectionView!.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        
        // collection object Post
        //        listPost = Posts()
        //        posts = listPost?.postList
        
        
        // get path to file json
        if let path = Bundle.main.path(forResource: "single_post", ofType: "json"){
            do {
                let data = try NSData.init(contentsOfFile: path, options: .mappedIfSafe)
                let jsonDictionary = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)
                
                if let dictionary = jsonDictionary as? [String:Any]{
                    if let postDictionary = dictionary["post"] as? [String:AnyObject]{
                        let post = Post()
                        post.setValuesForKeyWithDictionary(dictionary: postDictionary)
                        print(post.name!)
                        posts?.append(post)
                    }
                }
                
            }catch let err{
                print(err)
            }
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        imageCache.removeAllObjects()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCollectionViewCell
        cell.post = posts?[indexPath.item]
        cell.feedController = self
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts?[indexPath.item].status {
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: (14))], context: nil)
            
            let known:CGFloat =  8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 0.5 + 44 + 8
            return CGSize(width: view.frame.width, height: rect.height + known)
        }
        
        return CGSize(width: self.view.frame.width, height: 500)
    }
    
    var blackBackground = UIView()
    var imageView = UIImageView()
    var statusImageView = UIImageView()
    var navBarCoverView = UIView()
    var tapBarView = UIView()
    
    func animationImageView(statusImageView:UIImageView){
        self.statusImageView = statusImageView
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil){
            
            statusImageView.alpha = 0
            blackBackground.backgroundColor = UIColor.black
            blackBackground.frame = self.view.frame
            blackBackground.alpha = 0
            view.addSubview(blackBackground)
            
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarCoverView.backgroundColor = UIColor.black
            navBarCoverView.alpha = 0
            
            if let keyWindow = UIApplication.shared.keyWindow{
                keyWindow.addSubview(navBarCoverView)
                tapBarView.frame = CGRect(x: 0, y: keyWindow.frame.height - 49, width: 1000, height: 49)
                tapBarView.backgroundColor = UIColor.black
                tapBarView.alpha = 0
                keyWindow.addSubview(tapBarView)
            }
            
            
            
            
            imageView.isUserInteractionEnabled = true
            imageView.image = statusImageView.image
            imageView.contentMode = .scaleAspectFill
            imageView.frame = startingFrame
            imageView.clipsToBounds = true
            
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            
            self.view.addSubview(imageView)
            
            UIView.animate(withDuration: 0.75) {
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                let y = self.view.frame.height / 2 - height / 2
                self.imageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                self.blackBackground.alpha = 1
                self.navBarCoverView.alpha = 1
                self.tapBarView.alpha = 1
            }
            
        }
        
    }
    
    func zoomOut(){
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil){
            UIView.animate(withDuration: 0.75, animations: {
                self.imageView.frame = startingFrame
                self.blackBackground.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tapBarView.alpha = 0
            }, completion: { (didComplete) in
                self.imageView.removeFromSuperview()
                self.blackBackground.removeFromSuperview()
                self.statusImageView.alpha = 1
                self.navBarCoverView.removeFromSuperview()
                self.tapBarView.removeFromSuperview()
            })
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
}






