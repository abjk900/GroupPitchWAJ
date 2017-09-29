//
//  FriendTableViewCell.swift
//  g-erms
//
//  Created by Audrey Lim on 26/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    //****** All the object library *******
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var fullnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonAddFriend(_ sender: Any) {
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
