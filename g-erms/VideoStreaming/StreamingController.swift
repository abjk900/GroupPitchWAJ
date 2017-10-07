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


class StreamingController: UIViewController {
    

    @IBOutlet weak var streamingTableView: UITableView!
    
    var videoPosts : [VideoInfo] = []
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streamingTableView.dataSource = self
//        streamingTableView.delegate = self
        
        fetchPosts()

    }
    
    var videoInfo = [VideoInfo]()
    
    func fetchPosts() {

        //locating in currentlyUser
        guard let uid  = Auth.auth().currentUser?.uid else { return }

        //look the data that in the database and snapshot these values
        let ref = Database.database().reference().child("PostVideo").child(uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            //for saving whole value that in each uid(user)
            guard let dictionaries = snapshot.value as? [String:Any] else {return}
            
            dictionaries.forEach({ (key, value) in
                //for saving each value in uid
                //dictionaries 에 모든 값을 저장시키고 그 값을 dictionary로 분류시키는데 여기서 데이터베이스에 있는 정보를 videoInfo에 넣는다.
                guard let dictionary = value as? [String:Any] else { return }
        
                let newVideoInfo = VideoInfo(dictionary: dictionary)
              
                //append to event array
                self.videoPosts.append(newVideoInfo)
        
            })
            self.streamingTableView?.reloadData()
            }

    }

}



extension StreamingController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. get the cell
        guard let cell = streamingTableView.dequeueReusableCell(withIdentifier: "playingVideoCell", for: indexPath) as? StreamingTableViewCell  else { return UITableViewCell() }
        
        //2. setup
        let videoInfo = videoPosts[indexPath.row]

        cell.videoNameLabel.text = videoInfo.videoName
        cell.videoDescriptionLabel.text = videoInfo.videoDescription
//        cell.videoPlayButton.imageView?.image.
        
        return cell
    }
}
