//
//  LoginViewController+Handle.swift
//  GameOfChats
//
//  Created by Nguyen Nam on 12/29/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import Firebase

extension LoginViewController{
    
    
    // handle select image
    
    @objc func handleSelectProfileImage(){
        
        // let to create image picker to select
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
//        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    
    func handleRegisterUser(){
        guard let email = emailTextField.text ,
            let password = passwordTextField.text,
            let name = nameTextField.text
            else {
                return
        }
        auth.createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            guard let uid = user?.uid else{
                return
            }
            // upload image data to storage firebase
            
            if let imageData = UIImageJPEGRepresentation(self.profileImageView.image!, 0.1){
//                if let imageData = UIImagePNGRepresentation(self.profileImageView.image){

                // create a random string image name
                let imageName = NSUUID().uuidString
                self.storageRef.child("images").child("\(imageName).jpg").putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        print(error)
                        return
                    }
                    guard let imageURL = metadata?.downloadURL()?.absoluteString else{
                        return
                    }
                    let values = ["name": name, "email":email, "imageUrl" : imageURL] as [String : Any]
                    self.registerUserIntoFirebaseWithUID(uid: uid, values: values)
                })
            }
        }
    }
    
    
    private func registerUserIntoFirebaseWithUID(uid:String, values:[String:Any]){
        self.ref = Database.database().reference(fromURL: "https://gameofch-ce6fe.firebaseio.com/")
        self.ref.child("users").child(uid).updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil{
                print(err ?? "")
                return
            }
            self.dismiss(animated: true, completion: nil)
            print("Saved user successfully into firebase db")
        })
    }
    
    // MARK : delegate of image picker
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImage:UIImage?
        if let imageOriginal = info[UIImagePickerControllerOriginalImage] as? UIImage{
            selectedImage = imageOriginal
        }else if let imageEdited = info[UIImagePickerControllerEditedImage] as? UIImage{
            selectedImage = imageEdited
        }
        
        guard let imageSelectedFromLibrary = selectedImage else {
            return
        }
        profileImageView.image = imageSelectedFromLibrary
        dismiss(animated: true, completion: nil)
    }
    
}
