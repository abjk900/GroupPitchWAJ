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


    var selectedStudent : Student?
    var ref : DatabaseReference!
    var idEdit : Bool = true

    var profilePicURL : String = ""


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gameNameTextField: UITextField! {
        didSet {
            gameNameTextField.isUserInteractionEnabled = false  //cannot tapped

        }
    }
    @IBOutlet weak var gameEventNameTextField: UITextField!
    @IBOutlet weak var gameDatePicker: UIDatePicker!
    @IBOutlet weak var player1nameTextField: UITextField!
    @IBOutlet weak var player2nameTextField: UITextField!
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let name = selectedStudent?.name,
            let age = selectedStudent?.age,
            let imageURL = selectedStudent?.imageURL
            else {return}

        gameNameTextField.text = name
        ageTextField.text = "\(age)"
        editButton.titleLabel?.text = "Edit"


        profileImageView.loadImage(from: imageURL)



    } //end viewDidLoad

    @IBAction func buttonUploadTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func buttonSaveTapped(_ sender: Any) {

    }


    func uploadToStorage(_ image: UIImage) {
        let ref = Storage.storage().reference()  //link to own storage in firebase

        guard let xfilename = selectedStudent?.filename else {return}
        print(xfilename)

        //let profilePicRef = ref.child(autoGenerateUid+"/profile_pic.jpg")
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {return} //compreess to half quality

        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"



        ref.child("\(xfilename)").putData(imageData, metadata: metaData) { (meta, error) in
            if let validError = error {
                print(validError.localizedDescription)
            }

            if let downloadPath = meta?.downloadURL()?.absoluteString
            {
                self.profilePicURL = downloadPath
                self.profileImageView.image = image
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








