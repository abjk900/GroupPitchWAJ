//
//  StreamingTableViewCell.swift
//  g-erms
//
//  Created by Jae Kee Li on 10/6/17.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class StreamingTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var videoNameLabel: UILabel!
    
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
