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
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var signupButtonTapped: UIButton!{
        
        didSet{
            
            signupButtonTapped.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                let post : [String:Any] = ["name": userName, "email": email, "firstName": firstName ,"lastName": lastName, "imageURL": "","imageFilename": "","country": countryName]
                
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
    
}
