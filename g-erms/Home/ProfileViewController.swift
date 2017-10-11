//
//  ProfileViewController.swift
//  g-erms
//
//  Created by Jae Kee Li on 9/27/17.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class ProfileViewController: UIViewController {

    var ref : DatabaseReference!
    var profilePicURL : String = ""
    var currFilename : String = ""
    var selectedContact : Contact?
    var userId : String = ""
    var contacts : [Contact] = []
    
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.borderWidth = 1
            imageView.layer.masksToBounds = true
            //cell.profileImageView.layer.borderColor = UIColor.black
            imageView.layer.cornerRadius = imageView.frame.height/2
            
            imageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBAction func signOutBtnTapped(_ sender: Any) {
        signOutUser()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //display Profile Details
        fetchProfile()

        //dismiss keybaord when tap on vc
        self.hideKeyboardWhenTappedAround()
        
    }

    
    @IBAction func buttonEditTapped(_ sender: Any) {
        
        //save record
        ref = Database.database().reference()
        
        // guard let id = userId,  //selectedContact?.id,
        guard let userName = usernameTextField.text,
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let email = emailLabel.text
            //let image = profileImageView.image
            else {return}
        
       // let post : [String:Any] = ["name": userName, "email": email, "firstName": firstName ,"lastName": lastName, "imageURL": self.profilePicURL,"imageFilename": self.currFilename,"country": countryName]
        let post : [String:Any] = ["name": userName, "email": email, "firstName": firstName ,"lastName": lastName, "imageURL": self.profilePicURL,"imageFilename": self.currFilename]  //remember to add countrypicker
        
        print(post)
        
        //dig paths to reach a specific student
        ref.child("Users").child(userId).updateChildValues(post)
        
        //go back to homepage
        tabBarController?.selectedIndex = 0
        
    }
    
    @IBAction func buttonUploadTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func signOutUser() {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func fetchProfile() {
        //Get User Id
        ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        userId = uid
        
        
        
        ref.child("Users").child(userId).observe(.value, with: { (snapshot) in
            
            guard let info = snapshot.value as? [String: Any] else {return}
            
            //cast snapshot.value to correct Datatype
            if let name = info["name"] as? String,
                let firstName = info["firstName"] as? String,
                let lastName = info["lastName"] as? String,
                let email = info["email"] as? String,
                let country = info["country"] as? String,
                let imageURL = info["imageURL"] as? String,
                let sweetsCount = info["sweets"] as? Int,
                let filename = info["imageFilename"] as? String {
                
         //        let post : [String:Any] = ["name": userName, "email": email, "firstName": firstName ,"lastName": lastName, "imageURL": "","imageFilename": "","country": countryName]
                
                //create new contact object
                let newContact = Contact(anID: snapshot.key, aUsername: name, anEmail: email, anImageURL: imageURL, anFilename: filename, aFirstname: firstName, aLastname: lastName, aCountry: country, aSweets: sweetsCount)
                
                
                //pass the var
                self.selectedContact = newContact
                
                print(newContact)
                
                //append to contact array
                self.contacts.append(newContact)
                
                //Show on textField the Contact details
                guard let name = self.selectedContact?.username,
                    let firstName = self.selectedContact?.firstname,
                    let lastName = self.selectedContact?.lastname,
                    let email = self.selectedContact?.email,
                    let imageURL = self.selectedContact?.imageURL,
                    let filename = self.selectedContact?.filename
                    else {return}
                
                self.usernameTextField.text = name
                self.firstNameTextField.text = firstName
                self.lastNameTextField.text = lastName
                self.emailLabel.text = email
                //country  //default the picker from data from firebase
                
                self.imageView.loadImage(from: imageURL)
                
                //put to variable
                self.profilePicURL = imageURL
                self.currFilename = filename
                
            }
            
        })
        
        
    }
    
    
    func createErrorVC(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func uploadToStorage(_ image: UIImage) {
        let ref = Storage.storage().reference()  //link to own storage in firebase
        
        if selectedContact?.filename != "" {
            guard let xfilename = selectedContact?.filename else {return}
            currFilename = xfilename
        }
        else {
            let timeStamp = Date().timeIntervalSince1970  //generate auto id for the imageName
            currFilename = "\(timeStamp).jpeg"
        }
        
        print(currFilename)
        //let profilePicRef = ref.child(autoGenerateUid+"/profile_pic.jpg")
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {return} //compreess to half quality
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        ref.child("\(currFilename)").putData(imageData, metadata: metaData) { (meta, error) in
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            if let downloadPath = meta?.downloadURL()?.absoluteString
            {
                self.profilePicURL = downloadPath
                self.imageView.image = image
            }
        }
        
    }  //UploadToStorage
    


} //end


extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        defer {
            dismiss(animated: true, completion: nil)
        }
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        uploadToStorage(image)
        
    }
}


