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


class StreamingController: UIViewController {
    
    var videoPosts : [VideoInfo] = []
    var ref : DatabaseReference!
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer : AVPlayer?
    
    var videoInfos : VideoInfo? {
        didSet {
            guard let videoName = videoInfos?.videoName else { return }
            guard let videoDescription = videoInfos?.videoDescription else { return }
            guard let videoUrl = videoInfos?.videoUrl else { return }
        }
    }
    
    @IBAction func videoPlayButton(_ sender: UIButton) {
        
        self.present(self.avPlayerViewController, animated: true) {
            self.avPlayerViewController.player?.play()
        }
        
    }
    
    @IBOutlet weak var streamingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // cell
        streamingTableView.dataSource = self
        
        //fetchData
        fetchPosts()
        
        //Video
        let videoUrl = videoInfos?.videoUrl
        let url = URL(string : videoUrl!)
        
        self.avPlayer = AVPlayer(url: url!)
        self.avPlayerViewController.player = self.avPlayer
        
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
        
                let videoInfo = VideoInfo(dictionary: dictionary)
                print(videoInfo.videoName)
                print(videoInfo.videoDescription)
                print(videoInfo.videoUrl)
                //append to event array
                self.videoPosts.append(videoInfo)
                
//                let index = self.streamingTableView.count - 1
//                let indexPath = IndexPath(row: index, section: 0)
//                self.streamingTableView.insertRows(at: [indexPath], with: .right)
        
            })
            self.streamingTableView?.reloadData()
            }
//        DispatchQueue.main.async {
//
//        }
              self.streamingTableView?.reloadData()
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
//        let videoUrl = videoInfo.videoUrl
//        let url = URL(string : videoUrl)
//        let data = try? Data(contentsOf : url!)

        cell.videoNameLabel.text = videoInfo.videoName
        cell.videoDescriptionLabel.text = videoInfo.videoDescription
//        cell.playbutton.imageView?.image = UIImage(data: data!)
        
        return cell
    }
}


