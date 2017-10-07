//
//  videoInfo.swift
//  g-erms
//
//  Created by Jae Kee Li on 10/6/17.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import Foundation

struct VideoInfo {
    let videoUrl : String
    let videoName : String
    let videoDescription : String
    
    init(dictionary : [String : Any]) {
        self.videoUrl = dictionary["videoUrl"] as? String ?? ""
        self.videoName = dictionary["videoName"] as? String ?? ""
        self.videoDescription = dictionary["videoDescription"] as? String ?? ""
        
    }
}
