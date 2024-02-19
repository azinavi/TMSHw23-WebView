//
//  FAQViewController.swift
//  WebView
//
//  Created by azinavi on 17/2/24.
//

import UIKit
import WebKit

class FAQViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlSite = "https://"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView(siteURL: urlSite)
        
    }

    func setupWebView(siteURL: String) {
        let url = URL(string: siteURL)
        if !urlSite.isEmpty {
            let request = URLRequest(url: url!)
            self.webView.navigationDelegate = self
            self.webView.load(request)
        }
    }
    
    
}

