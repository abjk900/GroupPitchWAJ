//
//  StreamingViewController.swift
//  g-erms
//
//  Created by Audrey Lim on 26/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

//import UIKit
//
////matching with url dictionary
//struct SwitchVideo : Decodable {
//    let title : String
//    let url : String
//    let _id : String
//}
//
//struct VOD : Decodable {
//    let videos : [SwitchVideo]
//}
//
//class StreamingViewController: UIViewController {
//
//    //****** All the object library *******
//
//    @IBOutlet weak var searchBar: UISearchBar!
//
//    @IBOutlet weak var streamingTableView: UITableView!{
//        didSet{
//            streamingTableView.dataSource = self
//            //making fit window that for shwoing the videos
//            //need to type the view's heighy then can make auto.
//            streamingTableView.estimatedRowHeight = 220
//            streamingTableView.rowHeight = UITableViewAutomaticDimension
//        }
//    }
//
//    var videos : [SwitchVideo] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        feachVideo()
//    }
//
//    func feachVideo() {
//        //using with url
//        let jsonUrlString = "https://api.twitch.tv/kraken/videos/top"
//
//        guard let url = URL(string : jsonUrlString) else { return }
//        //        request.addValue("value", forHTTPHeaderField: "Key")
//        var request = URLRequest(url: url)
//        request.addValue("fc2eeba2o05hvyoss3ku2k5nazaqc0", forHTTPHeaderField: "Client-ID")
//        request.addValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "accccpet")
//
//        URLSession.shared.dataTask(with: request) { (data, response, err) in
//            if let err = err {
//                print("DataTask Error : \(err.localizedDescription)")
//                return
//            }
//
//            guard let data = data else {
//                print("Invaild Data")
//                return
//            }
//
//            //do could be using instead of guald let
//            do{
//                //the "SwitchVideo" need to be chnaged if it has covering array or dictionary.
//                let vods = try JSONDecoder().decode(VOD.self, from: data)
//                self.videos = vods.videos
//                //this is for what?
//                DispatchQueue.main.async {
//                    self.streamingTableView.reloadData()
//                }
//
//            } catch let jsonErr {
//                print("Error serializing json:", jsonErr)
//            }
//        }.resume()
//    }
//
//}
//
//extension StreamingViewController : UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return videos.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "streamingCell", for: indexPath) as? StreamingTableViewCell
//        else {
//            return UITableViewCell()
//        }
//
//        cell.videoNameLabel?.text = videos[indexPath.row].title
//
//
//            let str = "<iframe src=\"http://player.twitch.tv/?video=\(videos[indexPath.row]._id)4&autoplay=false\" height=\"\(cell.videoView.frame.height)\" width=\"\(cell.videoView.frame.width)\" frameborder=\"0\" scrolling=\"no\" allowfullscreen=\"true\"> </iframe>"
//        
//
//
//        cell.videoView?.loadHTMLString(str, baseURL: nil)
//
//
//        return cell
//    }
//
//}
//
