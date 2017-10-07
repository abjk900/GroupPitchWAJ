//
//  UpdatesViewController.swift
//  g-erms
//
//  Created by Tan Wei Liang on 07/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class UpdatesViewController: UIViewController {
    
    var selectedGamer : Gamer?
    var ref : DatabaseReference!
    var userId : String = ""
    var gamers : [Gamer] = []
    
    
    //****** All the object library *******
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBAction func segments(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            scrollView.setContentOffset(CGPoint(x: 0, y : 0), animated: true)
        case 1:
            scrollView.setContentOffset(CGPoint(x: 375, y : 0), animated: true)
            
        default:
            print ("")
        }
    }
    
    @IBOutlet weak var leaderboardTableView: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchGamers()
        leaderboardTableView.dataSource = self
        leaderboardTableView.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func fetchGamers () {
        
        ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        userId = uid
        
        ref.child("Top10Gamers").observe(.childAdded, with: { (snapshot) in
            
            guard let info = snapshot.value as? [String : Any] else {return}
            
            if  let name = info["name"] as? String,
                let earnings = info["earnings"] as? String,
                let game = info["game"] as? String,
                let playerID = info["playerID"] as? String,
                let tournament = info["tournament"] as? String,
                let profileImageURL = info["profileImageURL"] as? String
            {
                
                let newGamers = Gamer(aName: name, aGameTypes: game, aTournament: tournament, anEarnings: earnings, aPlayerID: playerID, aProfileImage: profileImageURL)
                
                self.selectedGamer = newGamers
                
                print(newGamers)
                
                
                
                
                
                // self.contacts.removeAll()
                DispatchQueue.main.async {
                    self.gamers.append(newGamers)
                    
                    let index = self.gamers.count - 1
                    let indexPath = IndexPath(row: index, section: 0)
                    self.leaderboardTableView.insertRows(at: [indexPath], with: .right)
                }
                
                
                return
            }
        })
        
        
    }
    
    
    
    
    
    
    
    
}

extension UpdatesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "top10Cell") else {return UITableViewCell() }
        
        let gamer = gamers[indexPath.row]
        
        
        
        cell.textLabel?.text = "\(indexPath.row + 1). " + gamer.name
        cell.detailTextLabel?.text = gamer.earnings
        
        return cell
    }
}

extension UpdatesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "Top10DetailsViewController") as? Top10DetailsViewController else {return}
        
        let selectedGamer = gamers[indexPath.row]
        
        destination.selectedGamer = selectedGamer
        
        navigationController?.pushViewController(destination, animated: true)
    }
}


