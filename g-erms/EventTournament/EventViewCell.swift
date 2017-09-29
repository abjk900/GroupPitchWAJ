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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
