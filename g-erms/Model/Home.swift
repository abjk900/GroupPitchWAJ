//
//  Home.swift
//  g-erms
//
//  Created by Tan Wei Liang on 28/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import Foundation

class Home  {
    
    var url : String?
    var title : String?
    var description : String?
    var urlImage : String?
    var publishedTime : Double?
    
    
    
    
    
    
    init (homeData : [String : Any]){
        
        
        if let anUrl = homeData["url"] as? String{
            url = anUrl
        }
        
        if let aTitle = homeData["title"] as? String {
            title = aTitle
        }
        
        if let aDescription = homeData["description"] as? String {
            description = aDescription
        }
        
        if let anUrlImage = homeData["urlToImage"] as? String {
            urlImage = anUrlImage
        }
        
        if let aPublishedTime = homeData["publishedTime"] as? Double {
            publishedTime = aPublishedTime
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
