//
//  HomeDetailsViewController.swift
//  g-erms
//
//  Created by Tan Wei Liang on 28/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class HomeDetailsViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {

    var selectedNews : Home?
    
    @IBOutlet weak var variableWebView: UIWebView!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        variableWebView.delegate = self
        loadurl(with: (selectedNews?.url)!)
    }
    func loadurl(with string: String){
        guard let url = URL(string: string) else {
            return
        }
        
        let request = URLRequest(url: url)
        variableWebView.loadRequest(request)
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
