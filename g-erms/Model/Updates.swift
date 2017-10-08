//
//  Updates.swift
//  g-erms
//
//  Created by Tan Wei Liang on 07/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import Foundation
import UIKit


class Updates {
    var name : String = ""
    var updatesURL : String = ""
    var gameImage : String = ""
    
    
    init (aName : String ,anUpdatesURL : String, aGameImage : String) {
        name = aName
        updatesURL = anUpdatesURL
        gameImage = aGameImage
        
    }
}
