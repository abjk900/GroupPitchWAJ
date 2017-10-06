//
//  helper.swift
//  g-erms
//
//  Created by Audrey Lim on 28/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from urlString : String) {
        //1. url
        guard let url = URL(string: urlString) else {return}
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            
        }
        task.resume()
    }
}

class DateHelper {
    static func createDateString(_ timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    static func createTimeString(_ timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "hh:mm a"
        
        return dateFormatter.string(from: date)
    }
}



