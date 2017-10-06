//
//  ShowEventDetailViewController.swift
//  g-erms
//
//  Created by Audrey Lim on 06/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class ShowEventDetailViewController: UIViewController {

    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var gameLogo: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playerName1: UILabel!
    @IBOutlet weak var playerCountry1: UILabel!
    @IBOutlet weak var playerCountry2: UILabel!
    @IBOutlet weak var playerName2: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
