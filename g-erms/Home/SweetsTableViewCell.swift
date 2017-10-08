//
//  SweetsTableViewCell.swift
//  g-erms
//
//  Created by Tan Wei Liang on 08/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class SweetsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sweetsImageView: UIImageView!
    
    @IBOutlet weak var sweetsLabel: UILabel!
    
    @IBOutlet weak var requirementLabel: UILabel!
    
    
    @IBAction func redeemBtnTapped(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
