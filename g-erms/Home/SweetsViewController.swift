//
//  SweetsViewController.swift
//  g-erms
//
//  Created by Tan Wei Liang on 06/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SweetsViewController: UIViewController {
    
    var selectedGift : Rewards?
    var ref : DatabaseReference!
    var userId : String = ""
    var reward : [Rewards] = []

    @IBOutlet weak var candyNumberLabel: UILabel!
 
    @IBOutlet weak var sweetsTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sweetsTableView.dataSource = self
        fetchGiftCards()
       
    }
    
    func createErrorAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Error", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion:  nil)
    }
    
    func fetchGiftCards () {
        
        ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        userId = uid
        
        ref.child("Redeem").observe(.childAdded, with: { (snapshot) in
            
            guard let info = snapshot.value as? [String : Any] else {return}
            
            if  let description = info["description"] as? String,
                let sweets = info["sweets"] as? String,
                let giftCardsImageURL = info["giftCardsImageURL"] as? String
            {
                
                let newRewards = Rewards(aDescription: description, aRequirements: sweets, anImageURL: giftCardsImageURL)
                
                
                //print(self.selectedGift)
                
                
                
                
                
                // self.contacts.removeAll()
                DispatchQueue.main.async {
                    self.reward.append(newRewards)
                    
                    let index = self.reward.count - 1
                    let indexPath = IndexPath(row: index, section: 0)
                    self.sweetsTableView.insertRows(at: [indexPath], with: .right)
                }
                
                
                return
            }
        })
        
        
    }
    
    
    

   
}

extension SweetsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reward.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "redeemCell", for: indexPath) as? SweetsTableViewCell else {return UITableViewCell() }
        
        let giftCards = reward[indexPath.row]
        
        cell.sweetsLabel.text = giftCards.description
        cell.requirementLabel.text = giftCards.requirements
        cell.sweetsImageView.loadImage(from: giftCards.imageURL!)
        
        
        
        return cell
    }
}

