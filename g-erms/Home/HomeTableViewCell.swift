//
//  HomeTableViewCell.swift
//  g-erms
//
//  Created by Audrey Lim on 26/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    //****** All the object library *******
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var newsArticleTitleLabel: UILabel!
    
    @IBOutlet weak var newsSummaryTextView: UITextView!
    
    @IBOutlet weak var newsPublishedTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
