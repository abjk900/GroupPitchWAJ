//
//  HomeViewController.swift
//  g-erms
//
//  Created by Audrey Lim on 26/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    var news : [Home] = []
    

    @IBAction func signOutButton(_ sender: Any) {
        signOutUser()
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }

    func signOutUser() {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func fetchData() {
        //send API request
        //1.get the url
        let urlString = "https://newsapi.org/v1/articles?source=ign&sortBy=top&apiKey=11fd246c28ab411f98aa89868f674180"
        guard let url = URL(string: urlString)
            else { return }
        
        //2. Get a URLSession
        let session = URLSession.shared
        
        //3.Create a URLTask
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask Error : \(error.localizedDescription)")
                return
            }
            
            
            guard let data = data
                else{
                    print("Invalid Data")
                    return
            }
            
            //print(data)
            //Convert to Json
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let validJson = json as? [String : Any]
                else {
                    return
            }
            
            guard let homeArray = validJson["articles"] as? [[String:Any]]
                else { return }
            
            
            for homeData in homeArray {
                
                let newHome = Home(homeData: homeData)
                self.news.append(newHome)
                
            }
            
            print(self.news.count)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        }
        //4. Start the task
        task.resume()
    }
    
    
    
}


extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1.get the cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        //2.setup
        let aNews = news[indexPath.row]
        cell.newsArticleTitleLabel.text = aNews.title
        cell.newsSummaryTextView.text = aNews.description
        
        guard let urlImage = aNews.urlImage else
        { return UITableViewCell() }
        cell.newsImageView.loadImage(from: urlImage)
        
        
       // cell.textLabel?.text = "\(indexPath.row + 1)"
      // cell.detailTextLabel?.text = news[indexPath.row].title
        
        return cell
    }
    
}

extension HomeViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //move to the next view
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: "HomeDetailsViewController" )
            as? HomeDetailsViewController
            else { return }
        //setup
        targetVC.selectedNews = news[indexPath.row]
        
        navigationController?.pushViewController(targetVC, animated: true)
    }
}





