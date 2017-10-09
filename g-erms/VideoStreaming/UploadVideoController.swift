//
//  UploadVideoController.swift
//  g-erms
//
//  Created by Jae Kee Li on 10/5/17.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices
import Firebase
import FirebaseStorage

class UploadVideoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var videoUploadProgress: UIProgressView!
    
    let streamingController = StreamingController()
    let imagePicketController = UIImagePickerController()
    var videoUrlName = ""
    var videoURL : URL?
    var videoImageURL = ""
    
    @IBOutlet weak var videoNameTextField: UITextField!
    
    @IBOutlet weak var videoDescription: UITextField!
    
    @IBOutlet weak var videoView: UIImageView!
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UIBarButtonItem) {
        
        imagePicketController.sourceType = .photoLibrary
        imagePicketController.delegate = self
        imagePicketController.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]//["public.image", "public.movie"]
        
        present(imagePicketController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var
     uploadVideoButton: UIButton!{
        didSet{
            uploadVideoButton.addTarget(self, action: #selector(handleUpload), for: .touchUpInside)
        }
    }
    
    @objc func handleUpload() {
        //the videoURL must be converted with string then can save in firebase.
        guard let videoNameTextField = videoNameTextField.text else { return }
        guard let videoDescriptionTexField = videoDescription.text else { return }
        guard let videoURL = videoURL else { return }
        
        guard let image = self.videoView.image else { return }
        
        guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
        
        videoUrlName = NSUUID().uuidString
        

        // For video file Storage
        let uploadVideoTask = Storage.storage().reference().child("gameVideo").child(videoUrlName).putFile(from: videoURL, metadata: nil) { (meta, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let videoURL = meta?.downloadURL()?.absoluteString {
                print("Successfully uploaded video file")
                print(videoURL)
            }
        }
        
        uploadVideoTask.observe(.progress) { (snapshot) in
            if let completedUnitCount = snapshot.progress?.completedUnitCount,
                let total = snapshot.progress?.totalUnitCount{
                self.videoUploadProgress.progress = Float(completedUnitCount)/Float(total)
                
                if self.videoUploadProgress.progress == 1 {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
        
        // For video image Storage
        let uploadVideoImageTask = Storage.storage().reference().child("gameVideoImage").child(videoUrlName).putData(uploadData, metadata: nil) { (meta, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let imageURL = meta?.downloadURL()?.absoluteString {
                print("Successfully uploaded video image")
                print(imageURL)
                self.videoImageURL = imageURL
            }
        }
        
        
        
        // For database
        
        //currently logined uid
      //  guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("PostVideo")   //.child(uid)
        
        let ref = userPostRef.childByAutoId() //each time to saving photo to create autoID.
        
        let values = ["videoName" : videoNameTextField, "videoDescription" : videoDescriptionTexField, "videoUrl" : videoURL.absoluteString, "videoUrlName" : "\(videoUrlName)", "imageURL" : videoImageURL] as [String : Any]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed to save post to DB", err)
                return
            }  
            
            print("Successfully save post to DB")
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func previewImageFromVideo(url : URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        var time = asset.duration
        time.value = min(time.value,2)
        
        do {
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            return nil
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //need this one "UIImagePickerControllerMediaURL" , not UIImagePickerControllerRefurenceURL
        
        videoURL = info["UIImagePickerControllerMediaURL"] as? URL
        
        print(videoURL)
        
        videoView.image = previewImageFromVideo(url: videoURL!)
        
        videoView.contentMode = .scaleAspectFit
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func videoPlayTapped(_ sender: UITapGestureRecognizer) {
        
        print("button tapped")
        
        if let videoURL = videoURL{
            
            let player = AVPlayer(url: videoURL)
            
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            
            present(playerViewController, animated: true, completion: {
                playerViewController.player!.play()
            })
            
        }
        
        
    }
}


