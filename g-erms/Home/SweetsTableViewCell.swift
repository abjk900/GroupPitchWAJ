//
//  SweetsTableViewCell.swift
//  g-erms
//
//  Created by Tan Wei Liang on 08/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

protocol SweetsCellDelegate {
    func triggerPopUp(_ friend: Contact)
}

class SweetsTableViewCell: UITableViewCell{
    
    var sweet : Contact?
    var delegate: SweetsCellDelegate?
    
    @IBOutlet weak var sweetsImageView: UIImageView!
    
    @IBOutlet weak var sweetsLabel: UILabel!
    
    @IBOutlet weak var requirementLabel: UILabel!
        
    
    @IBAction func redeemBtnTapped(_ sender: Any) {
        if delegate != nil,
            let validSweet = sweet {
            delegate?.triggerPopUp(validSweet)
        }
        
        
        //guard let button = sender as? UIButton else {return}
        //button.isHidden = true
 
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
