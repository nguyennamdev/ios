//
//  LoginViewController.swift
//  GameOfChats
//
//  Created by Nguyen Nam on 12/17/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class LoginViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK : Properties
    
    var storageRef:StorageReference!
    let auth = Auth.auth()
    var ref:DatabaseReference!
    var inputsContainerViewHeighAnchor:NSLayoutConstraint?
    var nameTextFieldHeighAnchor:NSLayoutConstraint?
    var emailTextFieldHeighAnchor:NSLayoutConstraint?
    var passwordTextFieldHeighAnchor:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(segmentControl)
        
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupSegmentControl()
        setupProfileImageView()
        emailTextField.delegate = self
        
        storageRef = Storage.storage().reference()
        
    }
    
    private func setupSegmentControl(){
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant:-12).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant:-24).isActive = true
    }
    
    private func setupProfileImageView(){
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: segmentControl.topAnchor, constant:-12).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImage))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setupLoginRegisterButton(){
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupInputsContainerView(){
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        //        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        inputsContainerViewHeighAnchor = NSLayoutConstraint(item: inputsContainerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        view.addConstraint(inputsContainerViewHeighAnchor!)
        inputsContainerView.addSubview(nameTextField)
        
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(passwordTextField)
        // contraint for name text field
        nameTextField.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeighAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeighAnchor?.isActive = true
        // constaint for password text field
        emailTextField.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeighAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier:1/3)
        emailTextFieldHeighAnchor?.isActive = true
        // contraint for email text field
        passwordTextField.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeighAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeighAnchor?.isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
    }
    @objc private func handleLoginRegister(){
        segmentControl.selectedSegmentIndex == 0 ? handleLogin() : handleRegisterUser()
    }
    
    
    private func handleLogin(){
        guard let email = emailTextField.text , let password = passwordTextField.text else {
            return
        }
        
        print(email, password)
        auth.signIn(withEmail: email, password: password) { (user, err) in
            if err != nil{
                print(err ?? "")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    @objc func changeIndexSegment(segment:UISegmentedControl) {
        let title = segment.titleForSegment(at: segment.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        inputsContainerViewHeighAnchor?.constant = segment.selectedSegmentIndex == 0 ? 100 : 150
        
        // change height of name text field
        nameTextFieldHeighAnchor?.isActive = false
        nameTextFieldHeighAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: segment.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeighAnchor?.isActive = true
        
        passwordTextFieldHeighAnchor?.isActive = false
        passwordTextFieldHeighAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: segment.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeighAnchor?.isActive = true
        
        emailTextFieldHeighAnchor?.isActive = false
        emailTextFieldHeighAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: segment.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeighAnchor?.isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        return true
    }
    
    let inputsContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let loginRegisterButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nameTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .bezel
        return tf
    }()
    
    let passwordTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .bezel
        return tf
    }()
    
    let emailTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .bezel
        return tf
    }()
    
    let profileImageView:UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "gameofthrones")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let segmentControl:UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.tintColor = UIColor.white
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(changeIndexSegment), for: .valueChanged)
        return sc
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
