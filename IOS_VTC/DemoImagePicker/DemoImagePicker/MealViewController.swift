//
//  ViewController.swift
//  DemoImagePicker
//
//  Created by Nguyen Nam on 8/2/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class MealViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var txtMealName: UITextField!
    @IBOutlet weak var imgMealImage: UIImageView!
    @IBOutlet weak var ratingControl: RatingController!
    
    var meal:Meal?

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.txtMealName.delegate = self
        updateSaveButtonState()
        if meal != nil{
            txtMealName.text = meal?.name
            imgMealImage.image = meal?.image
            ratingControl.rating = (meal?.rating)!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtMealName.resignFirstResponder()
        return true
    }
    
   
    
    @IBAction func selectImageFromLibary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        txtMealName.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        imgMealImage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            fatalError("Error")
        }
        let name = txtMealName.text ?? ""
        let photo:UIImage = imgMealImage.image!
        let rating:Int = ratingControl.rating
        meal = Meal(name: name, image: photo, rating: rating)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func updateSaveButtonState(){
        let text = txtMealName.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = txtMealName.text
    }

    @IBAction func cancelAddNew(_ sender: Any) {
       let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode{
            dismiss(animated: true, completion: nil)
        }
        else{
            navigationController?.popViewController(animated: true)
        }
        
    }
}

