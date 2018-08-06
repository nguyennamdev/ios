//
//  ChatLogController.swift
//  GameOfChats
//
//  Created by Nguyen Nam on 12/30/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import MobileCoreServices
import AVFoundation

private let reuseIdentifier = "Cell"

class ChatLogController:UICollectionViewController{
    
    // MARK : Properties
    
    var databaseRef:DatabaseReference!
    var bottomContainerViewAnchor:NSLayoutConstraint?
    var messages = [Message]()
    var startingImageFrame:CGRect?
    var blackBackgroundColor:UIView?
    
    var user:User?{
        didSet{
            observerMessage()
        }
    }
    
    
    
    // MARK : views
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inputMessageTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your message"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let sendButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(sendMessageWithText), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let uploadImageButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "image_icon"), for: .normal)
        button.tintColor = UIColor.lightGray
        button.addTarget(self, action: #selector(handleUploadImage), for: .touchUpInside)
        //        button.addGestureRecognizer(tapGesture)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference()
        
        navigationItem.title = user?.name
        self.collectionView?.backgroundColor = UIColor.white
        setupInputComponents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        inputMessageTextField.delegate = self
        
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.alwaysBounceVertical = true
    }
    
    // MARK : private func
    
    private func observerMessage(){
        guard let uid = Auth.auth().currentUser?.uid , let toId = user?.id else {
            return
        }
        let ref = Database.database().reference().child("user-posts").child(uid).child(toId)
        ref.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            // get message by message ref with message id
            self.fetchMessageWithMessageId(messageId: messageId)
        }, withCancel: nil)
        
    }
    
    private func fetchMessageWithMessageId(messageId:String){
        let messageRef = Database.database().reference().child("posts").child(messageId)
        messageRef.observeSingleEvent(of: .value, with: { (messageSnapshot) in
            if let dictionary = messageSnapshot.value as? [String:Any]{
                let message = Message()
                message.setValuesForKeys(dictionary)
                self.messages.append(message)
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                    let item = self.messages.count - 1
                    let indexPath = IndexPath(item: item, section: 0)
                    self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            }
        })
    }
    
    private func setupInputComponents(){
        view.addSubview(containerView)
        containerView.backgroundColor = UIColor.gray
        // constants
        
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomContainerViewAnchor = NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraint(bottomContainerViewAnchor!)
        
        setupSendButton()
        setupUploadImageButton()
        setupInputMessageTextField()
        
    }
    
    private func setupInputMessageTextField(){
        containerView.addSubview(inputMessageTextField)
        // constaints
        
        inputMessageTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputMessageTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1).isActive = true
        inputMessageTextField.leftAnchor.constraint(equalTo: uploadImageButton.rightAnchor, constant:8).isActive = true
        inputMessageTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
    private func setupSendButton(){
        containerView.addSubview(sendButton)
        // constaints
        
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setupUploadImageButton(){
        containerView.addSubview(uploadImageButton)
        // constaints
        
        uploadImageButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant:8).isActive = true
        uploadImageButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        uploadImageButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        uploadImageButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
    }
    
    // MARK : Actions
    
    @objc func sendMessageWithText(){
        guard let text = inputMessageTextField.text else {
            return
        }
        sendMessageWithProperties(properties: ["text" : text])
    }
    
    @objc func handleKeyboardNotification(notification:Notification){
        if let userInfo = notification.userInfo{
            let frameKeyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
            let isKeyboardShowing = notification.name == Notification.Name.UIKeyboardWillShow
            bottomContainerViewAnchor?.constant = isKeyboardShowing ? -frameKeyboard.height : 0
            if notification.name == Notification.Name.UIKeyboardWillShow{
                if self.messages.count != 0{
                    let item = self.messages.count - 1
                    let indexPath = IndexPath(item: item, section: 0)
                    self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            }
            
            
            // animate
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func handleUploadImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.mediaTypes = [kUTTypeImage as String , kUTTypeMovie as String]
        
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    fileprivate func sendMessageWithProperties(properties:[String:Any]){
        let ref =  databaseRef.child("posts")
        let childRef = ref.childByAutoId()
        let toId = self.user?.id
        let fromId = Auth.auth().currentUser?.uid
        let timestamp:Int = Int(NSDate().timeIntervalSince1970)
        var values = ["toId" :toId! , "fromId":fromId!, "timestamp" : timestamp] as [String : Any]
        
        // append properties dictionary values
        
        properties.forEach { (key ,value) in
            values[key] = value
        }
        
        print(values)
        
        childRef.updateChildValues(values) { (error, data) in
            if error != nil{
                print(error)
                return
            }
            self.inputMessageTextField.text = nil
            let userMessagesRef = Database.database().reference().child("user-posts").child(fromId!).child(toId!)
            let messageId = childRef.key
            userMessagesRef.updateChildValues([messageId:1])
            
            let recipentUserMessageRef = Database.database().reference().child("user-posts").child(toId!).child(fromId!)
            recipentUserMessageRef.updateChildValues([messageId : 1])
        }
    }
    
    
}

extension ChatLogController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputMessageTextField.resignFirstResponder()
        return true
    }
}


extension ChatLogController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ChatMessageCell
        cell?.textTextView.text = self.messages[indexPath.row].text
        let message = messages[indexPath.row]
        cell?.message = message
        cell?.user = user
        cell?.chatMessageDelegate = self
        // modify bubble view width
        if let text = message.text {
            let width = estimateFrameForText(text: text).width
            cell?.bubbleWidthConstaint?.constant = width + 32
            cell?.textTextView.isHidden = false
        }else {
            cell?.bubbleWidthConstaint?.constant = 200
            cell?.textTextView.isHidden = true
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let message = messages[indexPath.row]
        var height:CGFloat = 80                 // height default
        
       if let text = message.text {
            // get estimate height of text
            height = estimateFrameForText(text: text).height + 20
        }
        else{
            // solve for height
            if let imageHeight = message.imageHeight?.floatValue , let imageWidth = message.imageWidth?.floatValue {
                height = CGFloat(imageHeight / imageWidth * 200)
            }
        }
        return CGSize(width: view.frame.width , height:height)
    }
    
    
    fileprivate func estimateFrameForText(text:String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with:size , options: options , attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
}

extension ChatLogController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // user selected a video
        if let videoUrl = info[UIImagePickerControllerMediaURL] as? URL{
            uploadFileToFirebaseUsingMovie(videoUrl: videoUrl)
        }else {
            // user selected a image
            handleImageSelectedForInfo(info: info)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func uploadFileToFirebaseUsingMovie(videoUrl:URL){
        let fileName = "\(NSUUID().uuidString).mov"
        let uploadTask = Storage.storage().reference().child("message_videos").child(fileName).putFile(from: videoUrl, metadata: nil, completion: { (metadata, err) in
            if err != nil {
                return
            }
            if let storageUrl = metadata?.downloadURL()?.absoluteString {
                //                print(storageUrl)
                if let thumbnailImage = self.thumbnailImageForFileUrl(fileUrl: videoUrl){
                    self.uploadFileToFirebaseUsingImage(image: thumbnailImage, completion: { (imageUrl) in
                        self.sendMessageWithUploadMovie(storageURL: storageUrl, thumbnailImage: thumbnailImage, imageUrl:imageUrl)
                    })
                    
                }
            }
        })
        
        uploadTask.observe(.progress) { (snapshot) in
            if let completedUnitCount = snapshot.progress?.completedUnitCount {
                self.navigationItem.title = String(completedUnitCount)
            }
        }
        uploadTask.observe(.success) { (snapshot) in
            self.navigationItem.title = self.user?.name
        }
    }
    
    private func thumbnailImageForFileUrl(fileUrl:URL) -> UIImage?{
        let asset = AVAsset(url: fileUrl)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTime(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailCGImage)
        }catch {
            print(error)
        }
        return nil
    }
    
    private func handleImageSelectedForInfo(info:[String:Any]){
        var imageSeleted:UIImage?
        if let  imageOrifinal = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageSeleted = imageOrifinal
        }else if let imageEdited = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageSeleted = imageEdited
        }
        if let image = imageSeleted{
            uploadFileToFirebaseUsingImage(image: image, completion: { (imageUrl) in
                self.sendMessageWithUploadImage(imageUrl: imageUrl, image: image)
            })
        }
    }
    
    private func uploadFileToFirebaseUsingImage(image:UIImage, completion:@escaping (_ imageUrl:String) -> ()){
        let imageName = NSUUID().uuidString
        let storeRef = Storage.storage().reference().child("message_images").child(imageName)
        
        if let uploadData = UIImageJPEGRepresentation(image, 0.5){
            storeRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error)
                    return
                }
                if let imageUrl = metadata?.downloadURL()?.absoluteString{
                    completion(imageUrl)
                }
            })
        }
    }
    
    fileprivate func sendMessageWithUploadImage( imageUrl:String, image:UIImage){
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let values = ["imageUrl": imageUrl, "imageWidth":imageWidth, "imageHeight":imageHeight] as [String : Any]
        sendMessageWithProperties(properties: values)
    }
    
    fileprivate func sendMessageWithUploadMovie(storageURL:String, thumbnailImage:UIImage, imageUrl:String){
        let imageWidth = thumbnailImage.size.width
        let imageHeight = thumbnailImage.size.height
        let values = ["imageUrl":imageUrl ,"videoUrl": storageURL , "imageWidth" : imageWidth,"imageHeight":imageHeight] as [String : Any]
        sendMessageWithProperties(properties: values)
    }
}

extension ChatLogController : ChatMessageDelegate {
    func performZoomInForStatingImageView(image: UIImageView) {
        
        self.startingImageFrame = image.superview?.convert(image.frame, to: nil)
        
        //configuration zooming image view
        let zoomingImageView = UIImageView(frame: startingImageFrame!)
        zoomingImageView.backgroundColor = UIColor.red
        zoomingImageView.image = image.image
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
        zoomingImageView.isUserInteractionEnabled = true
        
        if let keyWindow = UIApplication.shared.keyWindow{
            self.blackBackgroundColor = UIView(frame: keyWindow.frame)
            self.blackBackgroundColor?.backgroundColor = UIColor.black
            self.blackBackgroundColor?.alpha = 0
            keyWindow.addSubview(blackBackgroundColor!)
            keyWindow.addSubview(zoomingImageView)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                
                self.blackBackgroundColor?.alpha = 1
                
                // math
                // h2 / w1 = h1 / w1
                // startingFrame.height = h1 and startingFrame.width = w1
                let height = (self.startingImageFrame?.height)! / (self.startingImageFrame?.width)! *  keyWindow.frame.width
                
                // change width zooming image
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height)
                zoomingImageView.center = keyWindow.center
                
            }, completion: nil)
        }
    }
    
    @objc private func handleZoomOut(tapGesture:UITapGestureRecognizer){
        if let zoomOutImageView = tapGesture.view {
            // need to animate back out to controller
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                zoomOutImageView.frame = self.startingImageFrame!
                self.blackBackgroundColor?.alpha = 0
                self.blackBackgroundColor = nil
            }, completion: { (completed) in
                zoomOutImageView.removeFromSuperview()
            })
        }
    }
}






