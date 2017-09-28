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
    @IBOutlet weak var eventViewTableView: UITableView!
    
    @IBOutlet weak var selectionSegmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func segmentedControl(_ sender: Any) {
        
    }
    
    
}
