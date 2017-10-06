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
    
    var selectedEvent : Event?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let eventName = selectedEvent?.eventName,
              let gameName = selectedEvent?.eventGameName,
              let eventDate = selectedEvent?.eventDate,
              let player1Name = selectedEvent?.player1Name,
              let player2Name = selectedEvent?.player2Name,
              let player1Country = selectedEvent?.player1Country,
              let player2Country = selectedEvent?.player2Country,
            //  let flagImag1 = selectedEvent?.player1FlagImage,
            //  let flagImag2 = selectedEvent?.player2FlagImage,
              let imageURL = selectedEvent?.imageURL
            else {return}
        
        eventLabel.text = eventName
        gameNameLabel.text = gameName
        
        guard let gameDate = Double(eventDate) else {return}
        
        dateLabel.text = DateHelper.createDateString(gameDate)
        timeLabel.text = DateHelper.createTimeString(gameDate)
        playerName1.text = player1Name
        playerName2.text = player2Name
        playerCountry1.text = player1Country
        playerCountry2.text = player2Country
        
      
        
        gameLogo.loadImage(from: imageURL)
        
    }

    
    

    


}
