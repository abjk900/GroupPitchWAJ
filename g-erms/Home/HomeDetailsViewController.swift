//
//  HomeDetailsViewController.swift
//  g-erms
//
//  Created by Tan Wei Liang on 28/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class HomeDetailsViewController: UIViewController {

    var selectedNews : Home?
    
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var textfieldView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func fetchNewsDetails (news : Home){
        textfieldView.text = news.description
        
        //1. url
        guard let url = URL(string : news.url!)
            else { return }
        
        //2. session
        let session = URLSession.shared
        
        //3.task
        let task = session.dataTask(with: url) { (data,  response, error) in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            guard let data = data,
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
                let jsonDict = jsonData as? [String : Any]
                
                else {
                    print( "Invalid Json")
                    return
            }
            
            if let news = jsonDict["url"] as? String {
                DispatchQueue.main.async {
                    self.textfieldView.text = "\(url)"
                }
        
    }
    
        }
    task.resume()
}
}
