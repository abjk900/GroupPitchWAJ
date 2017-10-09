//
//  EventDetailViewController.swift
//  g-erms
//
//  Created by Audrey Lim on 28/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import CountryPicker


class EventDetailViewController: UIViewController, CountryPickerDelegate {
    
    var selectedEvent : Event?
    var ref : DatabaseReference!
    var currFilename : String = ""
    var imagePicURL : String = ""

    var country1 : String = ""
    var country2 : String = ""
    var flagImg1 : String = ""
    var flagImg2 : String = ""
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var gameEventNameTextField: UITextField!
    @IBOutlet weak var gameDatePicker: UIDatePicker!
    @IBOutlet weak var player1nameTextField: UITextField!
    @IBOutlet weak var player2nameTextField: UITextField!
    @IBOutlet weak var picker1: CountryPicker!
    @IBOutlet weak var picker2: CountryPicker!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Add New Event"
        
        //dismiss keybaord when tap on vc
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        //get current country
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        //init Picker
        picker1.countryPickerDelegate = self
        picker1.showPhoneNumbers = false
        picker1.setCountry(code!)
        
        picker2.countryPickerDelegate = self
        picker2.showPhoneNumbers = false
        picker2.setCountry(code!)
        
    } //end viewDidLoad
    
    // a picker item was selected
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        //pick up anythink
        //code.text = phoneCode
        
        if picker == picker1 {
            country1 = name
            flagImg1 = "\(countryCode).png"
        } else {
            country2 = name
            flagImg2 = "\(countryCode).png"
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
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
            //let image = profileImageView.image
            else {return}
       
        let timestmp = ServerValue.timestamp()

        let date = gameDatePicker.date.timeIntervalSince1970
        
        //let createdDate = Date(timeIntervalSince1970: date)
        //let formattedDate = DateFormatter.dateFormat(fromTemplate: <#T##String#>, options: <#T##Int#>, locale: <#T##Locale?#>)
        let post : [String : Any] = ["gameName" : gameName, "eventName" : gameEventName, "eventDate" : date, "imageURL" : self.imagePicURL,"imageFilename" : currFilename,  "player1Name" : player1Name, "player2Name" : player2Name, "player1Country" : country1, "player2Country" : country2, "player1Flag" : flagImg1, "player2Flag" : flagImg2, "DateRecCreated": timestmp]
        print(post)
        //dig paths to reach a specific contact
        ref.child("Events").childByAutoId().updateChildValues(post)
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    func uploadToStorage(_ image: UIImage) {
        let ref = Storage.storage().reference()  //link to own storage in firebase
        
        let timeStamp = Date().timeIntervalSince1970  //generate auto id for the imageName
        //let profilePicRef = ref.child(autoGenerateUid+"/profile_pic.jpg")
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {return} //compreess to half quality
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        currFilename = "\(timeStamp).jpeg"
        
        ref.child("\(timeStamp).jpeg").putData(imageData, metadata: metaData) { (meta, error) in
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








