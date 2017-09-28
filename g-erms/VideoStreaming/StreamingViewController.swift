//
//  StreamingViewController.swift
//  g-erms
//
//  Created by Audrey Lim on 26/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

//matching with url dictionary
struct SwitchVideo : Decodable {
    let id : String
    let name : String
    let link : String
    let imageUrl : String
}

class StreamingViewController: UIViewController {
    
    //****** All the object library *******
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var streamingTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    func feachVideo() {
        //using with url
        let jsonUrlString = "http://api.letsbuildthatapp.com/jsondecondable/course"
        
        guard let url = URL(string : jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("DataTask Error : \(err.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Invaild Data")
                return
            }
            
            //do could be using instead of guald let
            do{
                //the "SwitchVideo" need to be chnaged if it has covering array or dictionary.
                let videoStreaming = try JSONDecoder().decode(SwitchVideo.self, from: data)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }
        
    }

   

}
