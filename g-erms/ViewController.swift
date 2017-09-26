//
//  ViewController.swift
//  g-erms
//
//  Created by Audrey Lim on 25/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    @IBAction func signOutButton(_ sender: Any) {
        signOutUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    func signOutUser() {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

}

