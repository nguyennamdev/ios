//
//  AddBookViewController.swift
//  DemoTableView
//
//  Created by Nguyen Nam on 8/7/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class AddEditBookViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var btnSaveBook: UIBarButtonItem!
    @IBOutlet weak var bookNavigationItem: UINavigationItem!
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtBookAuthor: UITextField!
    @IBOutlet weak var txtBookTitle: UITextField!
    var book:Book?
    public var isEditingBook: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPrice.delegate = self
        txtBookTitle.delegate = self
        txtBookAuthor.delegate = self
        updateSaveButtonState()
        
        if(book != nil){
            txtBookTitle.text = book?.title
            txtBookAuthor.text = book?.author
            txtPrice.text = "\(book?.price ?? 0)"
            imgBook.image = book?.image
            bookNavigationItem.title = "Edit Book"
        }else{
            bookNavigationItem.title = "Add Book"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) {
        txtPrice.resignFirstResponder()
        txtBookAuthor.resignFirstResponder()
        txtBookTitle.resignFirstResponder()
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("error \(info)")
        }
        imgBook.image = selectedImage
        dismiss(animated: true, completion: nil)
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtPrice.resignFirstResponder()
        txtBookAuthor.resignFirstResponder()
        txtBookTitle.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
   
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        if (txtBookTitle.text?.isEmpty)! || (txtBookAuthor.text?.isEmpty)! || (txtPrice.text?.isEmpty)! || imgBook.image == nil{
            btnSaveBook.isEnabled = false
        }
        else{
            btnSaveBook.isEnabled = true
        }
    }
    
    @IBAction func getBook(_ sender: UIBarButtonItem) {
        if book == nil{
            book = Book()
        }
        book?.title = txtBookTitle.text!
        book?.author = txtBookAuthor.text!
        book?.price = Double(txtPrice.text!)!
        book?.image = imgBook.image
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
