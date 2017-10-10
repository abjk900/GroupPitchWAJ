//
//  StreamingController.swift
//  g-erms
//
//  Created by Jae Kee Li on 10/5/17.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import AVFoundation
import AVKit


class StreamingController: UIViewController, UISearchBarDelegate {
    
     //****** All the object library *******
    var videoPosts : [VideoInfo] = []
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer : AVPlayer?
    var videoInfo = [VideoInfo]()
    var userId : String = ""
    var selectedContact : Contact?
    
    var searchActive : Bool = false
    var filtered:[VideoInfo] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    
    @IBOutlet weak var streamingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        //dismiss keybaord when tap on vc
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        
        // cell
        streamingTableView.dataSource = self
        streamingTableView.delegate = self as? UITableViewDelegate
       
        //fetchData
        fetchPosts()
        addSweets()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        streamingTableView.reloadData()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func addSweets() {
        //fetch user and add candy into the user
      let  ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        self.userId = uid
        ref.child("Users").child(self.userId).observe(.childChanged , with: { (snapshot) in
            
            guard let info = snapshot.value as? [String : Any] else {return}
            
             if let sweetsCount = info["sweets"] as? Int,
                let name = info["name"] as? String,
                let firstName = info["firstName"] as? String,
                let lastName = info["lastName"] as? String,
                let email = info["email"] as? String,
                let country = info["country"] as? String,
                let imageURL = info["imageURL"] as? String,
                let filename = info["imageFilename"] as? String  {
                
                let newContact = Contact(anID: snapshot.key, aUsername: name, anEmail: email, anImageURL: imageURL, anFilename: filename, aFirstname: firstName, aLastname: lastName, aCountry: country, aSweets: sweetsCount + 2)
                
                self.selectedContact = newContact
                
                //guard let sweetsCount = self.selectedContact?.sweets  else {return}

                ref.child("Users").child(uid).setValue(newContact)
                print("Successfully save post to DB")
                
            }
        })
    }
    
    func fetchPosts() {
        
        //locating in currentlyUser
      //  guard let uid  = Auth.auth().currentUser?.uid else { return }
        
        //
        let ref = Database.database().reference()
        
        //ref.child("PostVideo").child(uid).observe(.childAdded, with: { (snapshot) in
        ref.child("PostVideo").observe(.childAdded, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String:Any] else {return}
            
            if let videoName = dictionaries["videoName"] as? String,
                let videoDescription = dictionaries["videoDescription"] as? String,
                let videoUrlName = dictionaries["videoUrlName"] as? String,
                let videoUrl = dictionaries["videoUrl"] as? String,
                let userId = dictionaries["userId"] as? String,
                let videoImageUrl = dictionaries["imageURL"] as? String {
                
                let newVideo = VideoInfo(anID: snapshot.key, aViedoName: videoName, aVideoDescription: videoDescription, aVideoUrlName: videoUrlName, aVideoUrl: videoUrl, aUserId: userId, aVideoImageUrl: videoImageUrl)
                
                
                
                DispatchQueue.main.async {
                    self.videoPosts.append(newVideo)
                    let index = self.videoPosts.count - 1
                    let indexPath = IndexPath(row: index, section: 0)
                    self.streamingTableView.insertRows(at: [indexPath], with: .right)
                }

            }
        }
            
    )}
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        //filtered = data.filter({ (text) -> Bool in
        filtered = videoPosts.filter({ (videoInfo) -> Bool in
            let tmp: NSString = videoInfo.videoName as NSString
            let range = tmp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.streamingTableView.reloadData()
    }
    
    
    
} //end streaming controller

//        }
//            dictionaries.forEach({ (key, value) in
//                guard let dictionary = value as? [String : Any] else { return }
//                let videoInfo = VideoInfo(dictionary : dictionary)
//                print(videoInfo.videoName)
//                print(videoInfo.videoDescription)
//                print(videoInfo.videoUrlName)
//
//                let newVideoInfo = VideoInfo(dictionary: dictionary)
//
//                self.videoInfo.append(newVideoInfo)
//
//                let index = self.videoPosts.count - 1
//                let indexPath = IndexPath(row: index, section: 0)
//                self.streamingTableView.insertRows(at: [indexPath], with: .right)
//
//
//            })
//            DispatchQueue.main.async {
//                self.streamingTableView.reloadData()
//            }
//        }
//
//    )}
//}
        //look the data that in the database and snapshot these values
//        let ref = Database.database().reference().child("PostVideo").child(uid)
//        ref.observeSingleEvent(of: .value) { (snapshot) in
//            //for saving whole value that in each uid(user)
//            guard let dictionaries = snapshot.value as? [String:Any] else {return}
//
//            dictionaries.forEach({ (key, value) in
//                //for saving each value in uid
//                //dictionaries 에 모든 값을 저장시키고 그 값을 dictionary로 분류시키는데 여기서 데이터베이스에 있는 정보를 videoInfo에 넣는다.
//                guard let dictionary = value as? [String:Any] else { return }
//
//                let videoInfo = VideoInfo(dictionary: dictionary)
//                print(videoInfo.videoName)
//                print(videoInfo.videoDescription)
//                print(videoInfo.videoUrlName)
//                //append to event array
//                self.videoPosts.append(videoInfo)
//
//            })
//
//            DispatchQueue.main.async {
//                self.streamingTableView?.reloadData()
//            }
//        }
        
    
    



extension StreamingController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return videoPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. get the cell
        guard let cell = streamingTableView.dequeueReusableCell(withIdentifier: "playingVideoCell", for: indexPath) as? StreamingTableViewCell  else { return UITableViewCell() }
        
        //2. setup
        cell.delegate = self as StreamingTableViewCellDelegate

        if searchActive {
             let videoInfo = filtered[indexPath.row]
       
            let imageURL = videoInfo.videoImageUrl
            cell.videoUrlName = videoInfo.videoUrlName
            cell.videoPlayButton.imageView?.loadImage(from: videoInfo.videoUrl)
            cell.videoImageView.loadImage(from: imageURL)
            cell.videoNameLabel.text = videoInfo.videoName
            cell.videoDescriptionLabel.text = videoInfo.videoDescription
            
        } else {
            let videoInfo = videoPosts[indexPath.row]
           
            let imageURL = videoInfo.videoImageUrl
            cell.videoUrlName = videoInfo.videoUrlName
            cell.videoPlayButton.imageView?.loadImage(from: videoInfo.videoUrl)
            cell.videoImageView.loadImage(from: imageURL)
            cell.videoNameLabel.text = videoInfo.videoName
            cell.videoDescriptionLabel.text = videoInfo.videoDescription
            
        }
            
        
        
        
        return cell
    }
    
}

extension StreamingController: StreamingTableViewCellDelegate {
    func videoButtonPressedWithUrl(videoUrlName: String) {
        //Video
        let starsRef = Storage.storage().reference().child("gameVideo/\(videoUrlName)")
        
        starsRef.downloadURL { (url, err) in
            if let err = err {
                print("err", err)
            } else {
                DispatchQueue.main.async {
                    let player = AVPlayer(url: url!)
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    self.present(playerViewController, animated: true, completion: nil)
                    
                    
                }
                
            }
            self.streamingTableView.reloadData()
        }
       
    }
    
}


