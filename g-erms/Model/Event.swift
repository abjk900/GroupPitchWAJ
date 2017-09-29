//
//  Event.swift
//  g-erms
//
//  Created by Audrey Lim on 28/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import Foundation

class Event {
    var eventId : String = ""
    var eventGameName : String = ""
    var eventName : String = ""
    var eventDate : String = ""
    var imageURL : String = ""
    var filename : String = ""
    var player1Name : String = ""
    var player2Name : String = ""
 
    
    init(anEventId : String, aGameName : String, anEventName : String, anEventDate : String, anImageURL : String, aFilename : String, aPlayer1Name : String, aPlayer2Name : String) {
        eventId = anEventId
        eventGameName = aGameName
        eventName = anEventName
        eventDate = anEventDate
        imageURL = anImageURL
        filename = aFilename
        player1Name = aPlayer1Name
        player2Name = aPlayer2Name
    }
    
}
