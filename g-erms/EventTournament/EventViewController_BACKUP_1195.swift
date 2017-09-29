//
//  EventViewController.swift
//  g-erms
//
//  Created by Audrey Lim on 26/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import SDWebImage


class EventViewController: UIViewController {

    //****** All the object library *******
    var ref : DatabaseReference!
    var events : [Event] = []
    
    
    @IBOutlet weak var eventViewTableView: UITableView!
    
    @IBOutlet weak var selectionSegmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventViewTableView.delegate = self
        eventViewTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func segmentedControl(_ sender: Any) {
        
    }
    
    
} // end EventVC

extension EventViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        
        let rec = events[indexPath.row]
        cell.gameNameLabel.text = rec.eventGameName
        cell.gameEventNameLabel.text = rec.eventName
        cell.countryPlayerLabel.text = "\(rec.player1Name) vs \(rec.player2Name)"
        
        return cell
    }
    
}


extension EventViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = events[indexPath.row]
        
        //move to next VC
        //1. storyboard
        //2. instantiate the Target View Controller
        //3. setup
        //4. present
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let targetVC = mainStoryBoard.instantiateViewController(withIdentifier: "EventDetailViewController") as? EventDetailViewController
            else {return}
        
<<<<<<< HEAD
        //targetVC.contact = selectedContact
=======
        targetVC.selectedEvent = selectedEvent
>>>>>>> bd36235eb07f9ba2cebb0898308726513a7e4860
        
        present(targetVC, animated: true, completion: nil)
        
        
    }
    
    
    
}
