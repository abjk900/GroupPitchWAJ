//
//  FriendViewController.swift
//  g-erms
//
//  Created by Audrey Lim on 26/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class FriendViewController: UIViewController, UISearchBarDelegate {

    //****** All the object library *******
    var ref : DatabaseReference!
    var contacts : [Contact] = []
    
    var searchActive : Bool = false
    var filtered:[Contact] = []
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
       
        fetchContacts()
    }

    
    
    func fetchContacts() {
   
        ref = Database.database().reference()
        
        //observer child added works as a loop return each child individually
        ref.child("Users").observe(.childAdded, with: { (snapshot) in
            guard let info =  snapshot.value as? [String : Any] else {return}
            print("info : \(info)")
            print(snapshot.key)
            
            //cast snapshot.value to correct Datatype
            if let username = info["name"] as? String,
                let firstname = info["firstName"] as? String,
                let lastname = info["lastName"] as? String,
                let email = info["email"] as? String,
                let country = info["country"] as? String,
                let imageURL = info["imageURL"] as? String,
                let sweetsCount = info["sweets"] as? Int,
                let filename = info["imageFilename"] as? String {
                
                
              //  let fullname =  "\(firstname) \(lastname)"
                //create new contact object
                let newContact = Contact(anID: snapshot.key, aUsername: username, anEmail: email, anImageURL: imageURL, anFilename: filename, aFirstname: firstname, aLastname: lastname, aCountry: country, aSweets: sweetsCount)
                
                print(newContact)
                
                //append to contact array
                self.contacts.append(newContact)

                //this is more efficient
                //insert indv rows as we retrive idv items
                
              //  DispatchQueue.main.async {
                    let  index = self.contacts.count - 1
                    let indexPath = IndexPath(row: index, section: 0)
                    
                    self.tableView.insertRows(at: [indexPath], with: .right)
              //  }
                
                
            }
        })
        
        
        
        ref.child("Users").observe(.childChanged, with: { (snapshot) in
            guard let info = snapshot.value as? [String:Any] else {return}
            
            guard let username = info["name"] as? String,
                let firstname = info["firstName"] as? String,
                let lastname = info["lastName"] as? String,
                let email = info["email"] as? String,
                let country = info["country"] as? String,
                let imageURL = info["imageURL"] as? String,
                let filename = info["imageFilename"] as? String
                else {return}
            
            let fullname1 =  "\(firstname) \(lastname)"
            
            if let matchedIndex = self.contacts.index(where: { (contact) -> Bool in
                return contact.id == snapshot.key
            }) {
                let changedContact = self.contacts[matchedIndex]
                changedContact.username = username
                changedContact.fullname = fullname1
                changedContact.email = email
                changedContact.firstname = firstname
                changedContact.lastname = lastname
                changedContact.country = country
                changedContact.imageURL = imageURL
                changedContact.filename = filename
                
                DispatchQueue.main.async {
                    let indexPath = IndexPath(row: matchedIndex, section: 0)
                    self.tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
        })
        
        
    } // fetchContacts
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        //filtered = data.filter({ (text) -> Bool in
        filtered = contacts.filter({ (contact) -> Bool in
            let tmp: NSString = contact.username as NSString
            let range = tmp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }


}  //End FriendViewController

extension FriendViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as?
            FriendTableViewCell
            else { return UITableViewCell() }
        
        
        
        if searchActive {
            let filter = filtered[indexPath.row]
            cell.usernameLabel.text = filter.username
            cell.fullnameLabel.text = "\(filter.firstname) \(filter.lastname) :\(filter.country)"
            cell.delegate = self
            cell.friend = filter
            
            //let imageURL = filter.imageURL
            //cell.searchImageView.loadImage(from: imageURL)
            
        } else {
            let contact = contacts[indexPath.row]
            cell.usernameLabel.text = contact.username
            cell.fullnameLabel.text = "\(contact.firstname) \(contact.lastname) :\(contact.country)"
            cell.delegate = self
            cell.friend = contact
            
            
            //let imageURL = contact.imageURL
            //cell.searchImageView.loadImage(from: imageURL)
        }
        
        return cell
        
    }
    
}


extension FriendViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard let destination = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
        
        
       // let selectedContact = contacts[indexPath.row]
        
       // destination.selectedContact = selectedContact
       // navigationController?.pushViewController(destination, animated: true)
        
        
    }
    
}

extension FriendViewController : FriendsCellDelegate {
    func triggerPopUp(_ friend: Contact) {
        //Show alert popup
        let alert = UIAlertController(title: "Add Friend \(friend.username)", message: "Are You Sure ?", preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            //get the name
        }

        alert.addAction(ok)

        present(alert, animated: true, completion: nil)
        
        
        
        
    }
}

