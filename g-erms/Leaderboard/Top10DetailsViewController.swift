//
//  Top10DetailsViewController.swift
//  g-erms
//
//  Created by Tan Wei Liang on 05/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class Top10DetailsViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var playerIDLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var earningsLabel: UILabel!
    
    @IBOutlet weak var gameLabel: UILabel!
    
    @IBOutlet weak var tournamentLabel: UILabel!
    
    
    var selectedGamer : Gamer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let anImage = selectedGamer?.profileImage else {return}
        loadImage(urlString : anImage)
        playerIDLabel.text = selectedGamer?.playerID
        nameLabel.text = selectedGamer?.name
        earningsLabel.text = selectedGamer?.earnings
        gameLabel.text = selectedGamer?.gameTypes
        tournamentLabel.text = selectedGamer?.tournament

        // Do any additional setup after loading the view.
    }

    func loadImage(urlString : String) {
        //1.url
        //2.session
        //3.task
        //4.start
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }
  
}
