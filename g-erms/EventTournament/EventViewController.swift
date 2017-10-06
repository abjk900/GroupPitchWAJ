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
        
        selectionSegmentControl.selectedSegmentIndex = 1  //set the segment to Current Events
        
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
                let eventDate = info["eventDate"] as? Double,
                let imageURL = info["imageURL"] as? String,
                let filename = info["imageFilename"] as? String,
                let player1Name = info["player1Name"] as? String,
                let player2Name = info["player2Name"] as? String,
                let player1Country = info["player1Country"] as? String,
                let player2Country = info["player2Country"] as? String,
                let player1Flag = info["player1Flag"] as? String,
                let player2Flag = info["player2Flag"] as? String {
                
                
                
                //create new event object
                let newEvent = Event(anEventId: snapshot.key, aGameName: gameName, anEventName: eventName, anEventDate: self.createDateString(eventDate), anImageURL: imageURL, aFilename: filename, aPlayer1Name: player1Name, aPlayer2Name: player2Name, aPlayer1Country: player1Country, aPlayer2Country: player2Country, aplayer1FlagImage: player1Flag, aplayer2FlagImage: player2Flag)
                
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
    
    func createDateString(_ timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    
    
    
} // end EventVC

extension EventViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventViewCell.cellIdentifier) as? EventViewCell else {return UITableViewCell()}
        
        
        let rec = events[indexPath.row]
        cell.gameNameLabel.text = rec.eventGameName
        cell.gameEventNameLabel.text = rec.eventName
        cell.gameDateLabel.text = rec.eventDate
        let imageURL = rec.imageURL
        cell.gameLogo.loadImage(from: imageURL)
       
        // create an NSMutableAttributedString that we'll append everything to
        let fullString = NSMutableAttributedString(string: "")

        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: rec.player1FlagImage.lowercased())
        let image2Attachment = NSTextAttachment()
        image2Attachment.image = UIImage(named: rec.player2FlagImage.lowercased())

        // wrap the attachment in its own attributed string so we can append it
        let image1String = NSAttributedString(attachment: image1Attachment)
        let image2String = NSAttributedString(attachment: image2Attachment)

        // add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: " \(rec.player1Name) vs "))
        fullString.append(image2String)
        fullString.append(NSAttributedString(string: " \(rec.player2Name)"))

        // draw the result in a label
        cell.countryPlayerLabel.attributedText = fullString
   
        
        return cell
    }
    
}


extension EventViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "ShowEventDetailViewController") as? ShowEventDetailViewController else {return}
        
        
        let selectedEvent = events[indexPath.row]
        
        destination.selectedEvent = selectedEvent
        navigationController?.pushViewController(destination, animated: true)
        
        
    }
    
    
    
}
