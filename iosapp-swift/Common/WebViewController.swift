//
//  WebViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/3/7.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController {

    
    var webView: WKWebView!
    
    var progress: UIProgressView!
    
    var urlString: String!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        setupSubviews()
        loadRequest()
        
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
    }
    
    fileprivate func loadRequest() {
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    fileprivate func setupSubviews() {
        var rect = view.bounds
        rect.origin.y = 64
        rect.size.height = screen_height - 64
        webView = WKWebView(frame: rect)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        
        progress = UIProgressView()
        progress.frame = CGRect(x: 0, y: 64, width: screen_width, height: 10)
        progress.progressTintColor = UIColor.blue
        progress.trackTintColor = UIColor.clear
        view.addSubview(progress)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if self.webView.isEqual(object) {
                progress.alpha = 1.0
                progress.setProgress(Float(webView.estimatedProgress), animated: true)
                if webView.estimatedProgress >= 1.0 {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.progress.alpha = 0.0
                    }, completion: { (_) in
                        self.progress.setProgress(0.0, animated: true)
                    })
                }  
            }
        } else if keyPath == "title" {
            
            if self.webView.isEqual(object) {
                self.title = self.webView.title
                
            } else {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "title")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }

}

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if !(navigationAction.targetFrame?.isMainFrame)! {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
}




