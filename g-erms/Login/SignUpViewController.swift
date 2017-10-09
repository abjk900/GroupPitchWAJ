//
//  SignUpViewController.swift
//  g-erms
//
//  Created by Tan Wei Liang on 25/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import CountryPicker
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import FBSDKLoginKit

class SignUpViewController: UIViewController, CountryPickerDelegate {
    @IBOutlet weak var picker: CountryPicker!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
   
    @IBOutlet weak var profileImageView: UIImageView!
    @IBAction func uploadImageBtnTapped(_ sender: Any) {
        
        updateProfilePicEnable()
    }
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var signupButtonTapped: UIButton!{
        
        didSet{
            
            signupButtonTapped.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        }
        
    }
    
    
     var profilePicURL : String = ""
    var currFilename : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dismiss keybaord when tap on vc
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        //get corrent country
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        //init Picker
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = false
        picker.setCountry(code!)
    }
    
    // a picker item was selected
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        //pick up anythink
        //code.text = phoneCode
       countryLabel.text = name
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func signUp() {
        
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text,
            let userName = usernameTextField.text,
            let firstName = firstnameTextField.text,
            let lastName = lastnameTextField.text,
            
           let countryName = countryLabel.text
            
            else {return}
        
        
        if password != confirmPassword {
            createErrorVC("Password Error", "Password does not match")
        } else if email == "" || password == "" || confirmPassword == "" {
            createErrorVC("Missing input fill", "Please fill up your info appropriately in the respective spaces.")
        }
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                self.createErrorVC("Error", error.localizedDescription)
            }
            
            if let validUser = user {
                let ref = Database.database().reference()
                
                // let post : [String:Any] = ["email": email, "name": userName]
                let post : [String:Any] = ["name": userName, "email": email, "firstName": firstName ,"lastName": lastName, "imageURL": self.profilePicURL,"country": countryName,"imageFilename": self.currFilename]
                
                ref.child("Users").child(validUser.uid).setValue(post)
                
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func createErrorVC(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func updateProfilePicEnable() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        profileImageView.contentMode = .scaleAspectFit //3
        profileImageView.image = chosenImage //4
        //dismiss(animated:true, completion: nil) //5
        
        
        defer {
            dismiss(animated:true, completion: nil)
        }
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            return
        }
        
        uploadImageToStorage(image)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImageToStorage(_ image: UIImage) {
        let ref = Storage.storage().reference()
        
        let timeStamp = Date().timeIntervalSince1970
        
        //compress image so that the image isn't too big
        guard let imageData = UIImageJPEGRepresentation(image, 0.2) else {return}
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        //metadata gives us the url to retrieve the data on the cloud
        
        ref.child("\(timeStamp).jpeg").putData(imageData, metadata: metaData) { (meta, error) in
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            if let downloadPath = meta?.downloadURL()?.absoluteString {
                self.profilePicURL = downloadPath
                self.profileImageView.image = image
            }
        }
    }
    
}


extension SignUpViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer {
            //no matter what happens, this will get executed
            dismiss(animated: true, completion: nil)
        }
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        
        uploadImageToStorage(image)
        
        
    }
}

