//
//  EventDetailViewController.swift
//  g-erms
//
//  Created by Audrey Lim on 28/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage


class EventDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var gameEventNameTextField: UITextField!
    @IBOutlet weak var gameDatePicker: UIDatePicker!
    @IBOutlet weak var player1nameTextField: UITextField!
    @IBOutlet weak var player2nameTextField: UITextField!
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonUploadTapped(_ sender: Any) {
        
    }
    
    @IBAction func buttonSaveTapped(_ sender: Any) {
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
