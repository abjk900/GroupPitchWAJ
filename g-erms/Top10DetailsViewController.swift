//
//  Top10DetailsViewController.swift
//  g-erms
//
//  Created by Tan Wei Liang on 05/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class Top10DetailsViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var playerIDLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var earningsLabel: UILabel!
    
    @IBOutlet weak var gameLabel: UILabel!
    
    @IBOutlet weak var tournamentLabel: UILabel!
    
    
    var selectedGamer : Gamer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
}
