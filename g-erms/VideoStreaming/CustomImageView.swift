//
//  CustomImageView.swift
//  g-erms
//
//  Created by Jae Kee Li on 10/8/17.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
//1. making area for caching "String" and "UIImage"
var imageCache = [String : UIImage]()

//2. making function for converting "Stirng url" to "UIImage"
class CustomImageView : UIImageView{
    //taking url string
    var lastURLUsedToLoadImage : String?
    
    func loadImage(urlString : String){
        print("Loading image...")
        //the url are locate on the function
        lastURLUsedToLoadImage = urlString
        
        if let cacheImage = imageCache[urlString] {
            self.image = cacheImage
            return
        }
        
        //converting url String to URL type
        guard let url = URL(string : urlString) else { return }
        
        //showing data using url
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch post image", err)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage{
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data : imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
        }
        
    }

