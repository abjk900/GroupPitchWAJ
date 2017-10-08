//
//  UpdatesDetailsViewController.swift
//  g-erms
//
//  Created by Tan Wei Liang on 08/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class UpdatesDetailsViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {
    
    var selectedUpdates : Updates?

    @IBOutlet weak var variableView: UIWebView!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        variableView.delegate = self
        loadurl(with: (selectedUpdates?.updatesURL)!)
    }

    func loadurl(with string: String){
        guard let url = URL(string: string) else {
            return
        }
        
        let request = URLRequest(url: url)
        variableView.loadRequest(request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadingView.startAnimating()
        print("start loading")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadingView.stopAnimating()
        print("finish loading")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("fail with error :\(error.localizedDescription)")
        loadingView.stopAnimating()
    }
    
}
