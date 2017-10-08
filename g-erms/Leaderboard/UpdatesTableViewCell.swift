//
//  UpdatesTableViewCell.swift
//  g-erms
//
//  Created by Tan Wei Liang on 07/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class UpdatesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameImage: UIImageView!
    
    @IBOutlet weak var gameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
