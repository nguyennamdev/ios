//
//  FoodViewController.swift
//  DemoSaveDataWithSQL
//
//  Created by Nguyen Nam on 12/27/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import AssetsLibrary

class FoodViewController: UIViewController , UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ratingView: RatingControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var SqlManager = SQliteManager.getInstance()
    var food:Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateButtonSaveState()
        nameTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonSaveState()
    }
    
    @IBAction func saveFood(_ sender: Any) {
        let name = nameTextField.text
        let image = imageView.description
        let rating = ratingView.rating
        let food = Food(name!,image, rating)
        SqlManager.insertFood(food: food)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK : private function
    
    private func updateButtonSaveState(){
        if nameTextField.text == "" && ratingView.rating == 0 {
            saveButton.isEnabled = false
        }else{
            saveButton.isEnabled = true
        }
    }
    
    
    @objc private func didTapImage(){
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
 
    
    
    
 
    
}
