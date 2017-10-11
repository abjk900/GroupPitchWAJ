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
    var selectedContact : Contact?
    var contacts : [Contact] = []
    var userId2 : String = ""
    

    @IBOutlet weak var candyNumberLabel: UILabel!
 
    @IBOutlet weak var sweetsTableView: UITableView!
    
    @IBOutlet weak var numberOfSweetsLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sweetsTableView.dataSource = self
        
        ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        userId = uid
        
        fetchGiftCards()
        fetchSweets()
        
        
       
    }
    
    func createErrorAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Error", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion:  nil)
    }
    
    func fetchSweets () {
        
//        ref = Database.database().reference()
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        userId = uid
        
        ref.child("Users").child(userId).observe(.value, with: { (snapshot) in
            
            guard let info = snapshot.value as? [String : Any] else {return}
            
            if let sweetsCount = info["sweets"] as? Int,
                let name = info["name"] as? String,
                let firstName = info["firstName"] as? String,
                let lastName = info["lastName"] as? String,
                let email = info["email"] as? String,
                let country = info["country"] as? String,
                let imageURL = info["imageURL"] as? String,
                let filename = info["imageFilename"] as? String  {
                
                let newContact = Contact(anID: snapshot.key, aUsername: name, anEmail: email, anImageURL: imageURL, anFilename: filename, aFirstname: firstName, aLastname: lastName, aCountry: country, aSweets: sweetsCount)
                
                self.selectedContact = newContact
                //self.contacts.append(newContact)
                
                print(newContact.email)
                
                guard let sweetsCount = self.selectedContact?.sweets else {return}
                
                self.numberOfSweetsLabel.text = "Number of sweets : \(sweetsCount)"
                
               
             }
            })
        
    }
    
    func fetchGiftCards () {
        
//        ref = Database.database().reference()
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        userId = uid
        
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
        cell.sweet = selectedContact
//        cell.
        cell.delegate = self
        
        return cell
    }
}

extension SweetsViewController : SweetsCellDelegate {
    func triggerPopUp(_ friend: Contact) {
        
//        let alert = UIAlertView(title: "Sorry ", message: "You have not enough candy to redeem this item", delegate: nil, cancelButtonTitle: "Ok")
//        alert.show()
//
        
        var msgTitle = "Redeem sweets"
        guard let totalSweet = friend.sweets else {return}
        //Show alert popup
        if totalSweet < 25 {
            msgTitle = "Not enough to redeem!"
            deductSweets()
        } else {
            msgTitle = "Redeem sweets"
        }
        
        let alert = UIAlertController(title: msgTitle, message: "", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Dismiss", style: .default) { (action) in
            //get the name
        }
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    func deductSweets() {
        
        //let  ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        self.userId = uid
        //*****Increment the Sweet Count
        let sweetRef = Database.database().reference().child("Users").child(uid).child("sweets")
        
        sweetRef.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var sweetCount = currentData.value as? Int {
                sweetCount -= 25
                currentData.value = sweetCount
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        //******* End Increment the Sweet Count
    }
}
