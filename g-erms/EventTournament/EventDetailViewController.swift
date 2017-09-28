//
//  EventDetailViewController.swift
//  g-erms
//
//  Created by Audrey Lim on 28/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage


class EventDetailViewController: UIViewController {

    var selectedContact : Contact?
    var ref : DatabaseReference!
    var currFilename : String = ""
    var imagePicURL : String = ""
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var gameEventNameTextField: UITextField!
    @IBOutlet weak var gameDatePicker: UIDatePicker!
    @IBOutlet weak var player1nameTextField: UITextField!
    @IBOutlet weak var player2nameTextField: UITextField!
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    } //end viewDidLoad

    @IBAction func buttonUploadTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func buttonSaveTapped(_ sender: Any) {
        ref = Database.database().reference()
        guard let gameName = gameNameTextField.text,
            let gameEventName = gameEventNameTextField.text,
            //let gameDate = gameDatePicker.date,
            let player1Name = player1nameTextField.text,
            let player2Name = player2nameTextField.text
           // let play1Flag =
            //let image = profileImageView.image
            else {return}
        
        let date = gameDatePicker.date.timeIntervalSince1970
        //let createdDate = Date(timeIntervalSince1970: date)
        //let formattedDate = DateFormatter.dateFormat(fromTemplate: <#T##String#>, options: <#T##Int#>, locale: <#T##Locale?#>)
        let post : [String : Any] = ["gameName" : gameName, "eventName" : gameEventName, "eventDate" : date, "imageURL" : self.imagePicURL, "player1Name" : player1Name, "player2Name" : player2Name ]
        
        //dig paths to reach a specific student
        ref.child("Events").childByAutoId().updateChildValues(post)
    }
    
    
    func uploadToStorage(_ image: UIImage) {
        let ref = Storage.storage().reference()  //link to own storage in firebase
        
        let timeStamp = Date().timeIntervalSince1970  //generate auto id for the imageName
        currFilename = "\(timeStamp).jpeg"
        
            
//        guard let xfilename = selectedContact?.filename else {return}
//        print(xfilename)
        
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
                self.imagePicURL = downloadPath
                self.imageView.image = image
            }
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



} //End EventDetailViewController

extension EventDetailViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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








