//
//  LoginViewController.swift
//  g-erms
//
//  Created by Tan Wei Liang on 25/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
var fbloginID : String = ""
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var loginButton: UIButton!{
        didSet{
            loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        }
        
    }
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        //Login Email
        if Auth.auth().currentUser != nil {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController else { return }
            
            //skip login page straight to homepage
            present(vc, animated:  true, completion:  nil)
        }
        
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //view.addGestureRecognizer(tapGesture)
        
        

        
    }

    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!{
        didSet{
            fbLoginButton.delegate = self
            fbLoginButton.readPermissions = ["email","public_profile"]
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did Logout of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("Successfully logged in with Facebook...")
        
     
    
}
 func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //****Normal Email Login ********
    @objc func loginUser() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if self.emailTextField.text == "" {
                self.createErrorAlert("Empty Email Text Field", "Plaese Input Valid Email")
                return
            }
            else if self.passwordTextField.text == "" {
                self.createErrorAlert("Empty Password Text Field", "Please Input Valid Password")
                return
            }
            if let validError = error {
                
                print(validError.localizedDescription)
                self.createErrorAlert("Error", validError.localizedDescription)
            }
            
            if let validUser = user {
                print(validUser)
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController else { return }
                
                
                self.present(vc, animated:  true, completion:  nil)
                
            }
            
        }
        
    }
    
    func createErrorAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Error", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion:  nil)
        
    }
    
}
