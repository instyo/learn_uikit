//
//  WebViewController.swift
//  WebViewVideo
//
//  Created by Ikhwan on 11/12/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController, UIWebViewDelegate, WKNavigationDelegate {
    var webView: WKWebView!
    
    let url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: url)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

}
