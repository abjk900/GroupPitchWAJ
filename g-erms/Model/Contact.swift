//
//  Contact.swift
//  g-erms
//
//  Created by Audrey Lim on 28/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

//
//  Contact.swift
//  Instagram_Group2
//
//  Created by Audrey Lim on 13/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import Foundation


class Contact {
    var id : String = ""
    var username : String = ""
    var fullname : String = ""
    var email : String = ""
    var imageURL : String = ""
    var filename : String = ""
    var firstname : String = ""
    var lastname : String = ""
    var country : String = ""
    var sweets : Int?
    
    static var currentUser : Contact?
    
    init(anID : String, aUsername : String, anEmail : String, anImageURL : String, anFilename : String, aFirstname : String, aLastname : String, aCountry : String   , aSweets : Int) {
        id = anID
        username = aUsername
        email = anEmail
        imageURL = anImageURL
        filename = anFilename
        firstname = aFirstname
        lastname = aLastname
        country = aCountry
        sweets = aSweets
    }
    
}


