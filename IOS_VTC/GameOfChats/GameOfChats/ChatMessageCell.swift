//
//  ChatMessageCell.swift
//  GameOfChats
//
//  Created by Nguyen Nam on 1/4/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit
import FirebaseAuth
import AVFoundation

class ChatMessageCell: UICollectionViewCell {
    
    
    var chatMessageDelegate:ChatMessageDelegate?
    
    // Views
    let bubbleView:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textTextView:UITextView = {
        let tv = UITextView()
        tv.text = "Hello"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.backgroundColor = UIColor.clear
        tv.textAlignment = .left
        tv.isEditable = false
        //        tv.textColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let profileImageView:UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var messageImageView:UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomMessageImage)))
        return iv
    }()
    
    lazy var playButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "play-arrow"), for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(handlePlayVideo), for: .touchUpInside)
        return button
    }()
    
    let activityIndicatorView:UIActivityIndicatorView = {
        let at = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        at.hidesWhenStopped = true
        at.translatesAutoresizingMaskIntoConstraints = false
        return at
    }()
    
    // MARK : properties
    
    var user:User?{
        didSet{
            guard let imageUrl = user?.imageUrl else {
                return
            }
            profileImageView.loadImageUsingCacheWithURL(urlString: imageUrl)
        }
    }
    var message:Message?{
        didSet{
            setupCell(message: message!)
        }
    }
    var bubbleWidthConstaint:NSLayoutConstraint?
    var bubbleRightConstaint:NSLayoutConstraint?
    var bubbleLeftConstaint:NSLayoutConstraint?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextView()
        setupProfileImageView()
        setupMessageImageView()
        setupPlayButton()
        setupActivityView()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerLayer?.removeFromSuperlayer()
        player?.pause()
        activityIndicatorView.stopAnimating()
    }
    
    // MARK : private functions
    
    fileprivate func setupCell(message:Message){
        if message.fromId == Auth.auth().currentUser?.uid {
            //outgoing blue
            self.bubbleView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            self.bubbleRightConstaint?.isActive = true
            self.bubbleLeftConstaint?.isActive = false
            self.profileImageView.isHidden = true
        }else{
            //incoming gray
            self.bubbleView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.bubbleRightConstaint?.isActive = false
            self.bubbleLeftConstaint?.isActive = true
            self.profileImageView.isHidden = false
        }
        
        if let imageUrl = message.imageUrl {
            self.messageImageView.loadImageUsingCacheWithURL(urlString: imageUrl)
            self.bubbleView.backgroundColor = UIColor.clear
        }else{
            self.messageImageView.image = nil
        }
        
        self.playButton.isHidden = message.videoUrl == nil

        
    }
    
    private func setupTextView(){
        addSubview(bubbleView)
        bubbleView.addSubview(textTextView)
        
        bubbleLeftConstaint = bubbleView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8)
        bubbleLeftConstaint?.isActive = false
        
        bubbleRightConstaint = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant:-12)
        bubbleRightConstaint?.isActive = true
        
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        bubbleWidthConstaint = NSLayoutConstraint(item: bubbleView, attribute: .width, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: 200)
        self.addConstraint(bubbleWidthConstaint!)
        
        
        textTextView.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor).isActive = true
        textTextView.widthAnchor.constraint(equalTo: bubbleView.widthAnchor).isActive = true
        textTextView.heightAnchor.constraint(equalTo: bubbleView.heightAnchor).isActive = true
        textTextView.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        
        
    }
    
    private func setupProfileImageView(){
        addSubview(profileImageView)
        //x,y,w,h
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    private func setupMessageImageView(){
        bubbleView.addSubview(messageImageView)
        // x,y,w,h
        messageImageView.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        messageImageView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor).isActive = true
        messageImageView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor).isActive = true
        messageImageView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
    }
    
    private func setupPlayButton(){
        bubbleView.addSubview(playButton)
        // x,y,w,h
        playButton.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    private func setupActivityView(){
        bubbleView.addSubview(activityIndicatorView)
        // x,y,w,h
        activityIndicatorView.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK : Actions 
    
    @objc private func handleZoomMessageImage(tap:UITapGestureRecognizer){
        if message?.videoUrl != nil{
            return
        }
        
        let image = tap.view as? UIImageView // cast down view click to image view
        chatMessageDelegate?.performZoomInForStatingImageView(image: image!)
    }
    
    var playerLayer:AVPlayerLayer?
    var player:AVPlayer?
    
    @objc private func handlePlayVideo(){
        if let videoUrl = message?.videoUrl {
            player = AVPlayer(url: URL(string: videoUrl)!)
            // need player layer to display
            
            playerLayer = AVPlayerLayer(player: player!)
            playerLayer?.frame = bubbleView.bounds
            bubbleView.layer.addSublayer(playerLayer!)
            player?.play()
            activityIndicatorView.startAnimating()
            playButton.isHidden = true
        }
    }
    
    
}















