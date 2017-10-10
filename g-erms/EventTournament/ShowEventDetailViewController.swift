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
              let eventTime = selectedEvent?.eventTime,
              let player1 = selectedEvent?.player1Name,
              let player2 = selectedEvent?.player2Name,
              let country1 = selectedEvent?.player1Country,
              let country2 = selectedEvent?.player2Country,
              let flagImag1 = selectedEvent?.player1FlagImage,
              let flagImag2 = selectedEvent?.player2FlagImage,
              let imageURL = selectedEvent?.imageURL
            else {return}
        
        eventLabel.text = eventName
        gameNameLabel.text = gameName
        
        
        playerName1.text = player1
        playerName2.text = player2
        dateLabel.text = eventDate
        timeLabel.text = eventTime
   
        gameLogo.loadImage(from: imageURL)
        
        //**** Format the Country with Flag ***********
        // create an NSMutableAttributedString that we'll append everything to
        let fullString = NSMutableAttributedString(string: "")
        let fullString1 = NSMutableAttributedString(string: "")
        
        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: flagImag1.lowercased())
        let image2Attachment = NSTextAttachment()
        image2Attachment.image = UIImage(named: flagImag2.lowercased())
        
        // wrap the attachment in its own attributed string so we can append it
        let image1String = NSAttributedString(attachment: image1Attachment)
        let image2String = NSAttributedString(attachment: image2Attachment)
        
        // add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: " \(country1)"))
        fullString1.append(image2String)
        fullString1.append(NSAttributedString(string: " \(country2)"))
        
        
        // draw the result in a label
        playerCountry1.attributedText = fullString
        playerCountry2.attributedText = fullString1
   
        
    }

    
    

    


}
