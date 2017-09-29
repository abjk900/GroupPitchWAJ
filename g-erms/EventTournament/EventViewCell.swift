//
//  EventViewCell.swift
//  g-erms
//
//  Created by Audrey Lim on 29/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class EventViewCell: UITableViewCell {

    static let cellIdentifier = "EventViewCell"
    static let cellNib = UINib(nibName: "EventViewCell", bundle: Bundle.main)
    
    @IBOutlet weak var gameLogo: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    @IBOutlet weak var gameEventNameLabel: UILabel!
    @IBOutlet weak var countryPlayerLabel: UILabel!
    
    @IBOutlet weak var imageFollowingTapped: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
