//
//  videoInfo.swift
//  g-erms
//
//  Created by Jae Kee Li on 10/6/17.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import Foundation

class VideoInfo {
    var id : String = ""
    var videoUrlName : String
    var videoName : String
    var videoDescription : String
    
    init(anID : String ,aViedoName: String, aVideoDescription: String, aVideoUrlName: String) {
        
        id = anID
        videoName = aViedoName
        videoDescription = aVideoDescription
        videoUrlName = aVideoUrlName

    }
}
