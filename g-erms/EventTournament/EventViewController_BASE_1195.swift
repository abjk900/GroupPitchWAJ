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
    var contacts : [Contact] = []
    
    
    @IBOutlet weak var eventViewTableView: UITableView!
    
    @IBOutlet weak var selectionSegmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func segmentedControl(_ sender: Any) {
        
    }
    
    
} // end EventVC

extension EventViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let rec = contacts[indexPath.row]
       // cell.textLabel?.text = rec.name
       // cell.detailTextLabel?.text = "\(std.id ?? "No ID") : \(std.age)"
        
        
        
        
        return cell
    }
    
}


extension EventViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = contacts[indexPath.row]
        
        //move to next VC
        //1. storyboard
        //2. instantiate the Target View Controller
        //3. setup
        //4. present
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let targetVC = mainStoryBoard.instantiateViewController(withIdentifier: "EventDetailViewController") as? EventDetailViewController
            else {return}
        
        targetVC.contact = selectedContact
        
        present(targetVC, animated: true, completion: nil)
        
        
    }
    
    
    
}
