//
//  Top10ViewController.swift
//  g-erms
//
//  Created by Tan Wei Liang on 05/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

// NOTE FOR THE USE OF UPLOAD TOP 10 PLAYERS TO THE FIREBASE


import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
// NOTE FOR THE USE OF UPLOAD TOP 10 PLAYERS TO THE FIREBASE
class Top10ViewController: UIViewController {
    
    let picker = UIImagePickerController()
    var profilePicURL : String = ""
    var imageFilename : String = ""
    var selectedUser : Contact?
    var ref : DatabaseReference!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    

    
    
    
    @IBAction func uploadImageBtnTapped(_ sender: Any) {
        updateProfilePicEnable()
    }
    @IBAction func createBtn(_ sender: Any) {
        
        ref = Database.database().reference()
        guard let description = nameTextField.text,
              let profileImage = profileImageView.image
            
            else { return }
        
        let post : [String:Any] = ["description": description,"giftCardsImageURL": self.profilePicURL]
        
        ref.child("Redeem").childByAutoId().updateChildValues(post)
        
        
        self.navigationController?.popViewController(animated: true)
        
        
        
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
    
    
    
    func createErrorVC(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func updateProfilePicEnable() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let imageURL = selectedUser?.imageURL else { return }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
}

extension Top10ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer {
            //no matter what happens, this will get executed
            dismiss(animated: true, completion: nil)
        }
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        
        
        uploadImageToStorage(image)
        
        
    }
}



   

