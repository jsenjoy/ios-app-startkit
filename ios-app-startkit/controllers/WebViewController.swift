//
//  PersonalController.swift
//  ios-app-startkit
//
//  Created by Boom.Lee on 3/15/16.
//  Copyright © 2016 Boom.Lee. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: ViewController, WKNavigationDelegate, WKScriptMessageHandler {
  
  var webview: WKWebView!
  var indicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = "Webview 君"
    self.navigationItem.hidesBackButton = true
    self.addBackground("webview.jpeg")
    self.initView()
  }
  
  func initView() {
    self.initWebView()
    self.initIndicator()
  }
  
  func initWebView() {
    let config = WKWebViewConfiguration()
    config.userContentController.addScriptMessageHandler(self, name: "webViewApp")
    
    webview = WKWebView(frame: view.frame, configuration: config)
    
    let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("index", ofType: "html", inDirectory: "resource")!)
    
    let request = NSMutableURLRequest(URL: url)
    webview.loadRequest(request)
    
    // 设置 webview 为透明
    webview.opaque = false
    webview.backgroundColor = UIColor.clearColor()
    
    view.addSubview(webview)
    webview.navigationDelegate = self
  }
  
  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    self.removeIndicator()
    
    let username = UserStore.get("username") as! String
    
    let script = "window.updateUserName('" + username + "')"
    
    webview.evaluateJavaScript(script) {
      (result, error) in
//      print(result)
//      print(error)
    }
  }
  
  func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
    let dict = message.body as! Dictionary<String, String>
    handleMessage(dict)
  }
  
  func initIndicator() {
    indicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
    indicator.center = self.view.center
    indicator.hidesWhenStopped = true
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
    indicator.startAnimating()
    view.addSubview(indicator)
  }
  
  func removeIndicator() {
    indicator.stopAnimating()
    indicator.removeFromSuperview()
  }
  
  func handleMessage(dict: Dictionary<String, String>) {
    print(dict)
    
    if let method = dict["method"] {
      if method == "push" {
        navigationController?.pushViewController(WebViewController(), animated: true)
      }
      
      if method == "pop" {
        navigationController?.popViewControllerAnimated(true)
      }
      
      if method == "setTitle" {
        if let title = dict["title"] {
          self.navigationItem.title = title
        }
      }
    }
  }
}
