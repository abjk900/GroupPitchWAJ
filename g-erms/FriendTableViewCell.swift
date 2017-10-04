//
//  FriendTableViewCell.swift
//  g-erms
//
//  Created by Audrey Lim on 26/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

protocol FriendsCellDelegate {
    func triggerPopUp(_ friend: Contact)
}

class FriendTableViewCell: UITableViewCell {
    
    //****** All the object library *******
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var fullnameLabel: UILabel!
    
    var friend : Contact?
    var delegate: FriendsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonAddFriend(_ sender: Any) {
        if delegate != nil,
            let validFriend = friend {
                delegate?.triggerPopUp(validFriend)
        }
       
        //hide button after tapped
        guard let button = sender as? UIButton else {return}
        button.isHidden = true
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
