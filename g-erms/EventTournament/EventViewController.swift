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
    
    
    @IBOutlet weak var eventViewTableView: UITableView! {
        didSet{
            eventViewTableView.estimatedRowHeight = 100
            eventViewTableView.rowHeight = UITableViewAutomaticDimension
            eventViewTableView.register(EventViewCell.cellNib, forCellReuseIdentifier: EventViewCell.cellIdentifier)
        }
    }
    
    @IBOutlet weak var selectionSegmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventViewTableView.delegate = self
        eventViewTableView.dataSource = self
        
        
        fetchEvents()
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func segmentedControl(_ sender: Any) {
        
    }
    
    func fetchEvents() {
        ref = Database.database().reference()
        
        //observer child added works as a loop return each child individually
        ref.child("Events").observe(.childAdded, with: { (snapshot) in
            guard let info =  snapshot.value as? [String : Any] else {return}
            print("info : \(info)")
            print(snapshot)
            print(snapshot.key)
            
            
            //cast snapshot.value to correct Datatype
            if let gameName = info["gameName"] as? String,
                let eventName = info["eventName"] as? String,
                //let eventDate = info["eventDate"] as? String,
                let imageURL = info["imageURL"] as? String,
                let filename = info["imageFilename"] as? String,
                let player1Name = info["player1Name"] as? String,
                let player2Name = info["player2Name"] as? String {
                
                //create new event object
                let newEvent = Event(anEventId: snapshot.key, aGameName: gameName, anEventName: eventName, anEventDate: "30/09/2017", anImageURL: imageURL, aFilename: filename, aPlayer1Name: player1Name, aPlayer2Name: player2Name)
                
                //append to event array
                self.events.append(newEvent)
  
                //this is more efficient
                //insert indv rows as we retrive idv items
                let  index = self.events.count - 1
                let indexPath = IndexPath(row: index, section: 0)
                self.eventViewTableView.insertRows(at: [indexPath], with: .right)
                
                
            }
        })
        
//        ref.child("students").observe(.value, with: {
//            (snapshot) in
//            guard let info = snapshot.value as? [String : Any]
//                else {return}
//            print(info)
//        })
        
//        ref.child("students").observe(.childRemoved, with: { (snapshot) in
//            guard let info = snapshot.value as? [String:Any] else {return}
//            print(info)
//
//            let deletedID = snapshot.key
//
//            //filters through students returns index where Boolean condition is fullfilled
//            if let deletedIndex = self.events.index(where: { (event) -> Bool in
//                return event.id == deletedID
//            }) {
//                //remove event when deletedIndex is found
//                self.events.remove(at: deletedIndex)
//                //let index = self.students.count - 1
//                let indexPath = IndexPath(row: deletedIndex, section: 0)
//
//                self.eventViewTableView.deleteRows(at: [indexPath], with: .fade)
//            }
//        })
        
//        ref.child("Events").observe(.childChanged, with: { (snapshot) in
//            guard let info = snapshot.value as? [String:Any] else {return}
//
//            guard let name = info["name"] as? String,
//                let age = info["age"] as? Int,
//                let imageURL = info["imageURL"] as? String
//                else {return}
//
//            if let matchedIndex = self.events.index(where: { (event) -> Bool in
//                return event.id == snapshot.key
//            }) {
//                let changedEvent = self.events[matchedIndex]
//                changedEvent.age = age
//                changedEvent.name = name
//                changedEvent.imageURL = imageURL
//
//
//                let indexPath = IndexPath(row: matchedIndex, section: 0)
//                self.eventViewTableView.reloadRows(at: [indexPath], with: .none)
//            }
//        })
        
        
    } // fetchEvents
    
    
    
    
} // end EventVC

extension EventViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        
        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: EventViewCell.cellIdentifier) as? EventViewCell else {return UITableViewCell()}
        
        
        let rec = events[indexPath.row]
        cell.gameNameLabel.text = rec.eventGameName
        cell.gameEventNameLabel.text = rec.eventName
        cell.countryPlayerLabel.text = "\(rec.player1Name) vs \(rec.player2Name)"
        
        return cell2
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
        
        targetVC.selectedEvent = selectedEvent
        
        present(targetVC, animated: true, completion: nil)
        
        
    }
    
    
    
}
