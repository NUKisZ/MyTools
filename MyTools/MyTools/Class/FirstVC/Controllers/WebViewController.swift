//
//  WebViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/4/25.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
import JavaScriptCore
import WebKit

class WebViewController: WKWebViewBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //createWebView()
        createWKWebView(urlString: "https://www.baidu.com")
        createProgressView()
    }
    func createWebView(){
        navigationController?.automaticallyAdjustsScrollViewInsets=false
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        view.addSubview(webView)
        let request = URLRequest(url: URL(string: "https://www.baidu.com")!)
        webView.load(request)
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension WebViewController{
    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.webView(webView, didFinish: navigation)
        webView.evaluateJavaScript("showAlert('一个弹框')") { (item, error) in
            
        }
    }
    override func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        super.webView(webView, didFail: navigation, withError: error)
        ZKTools.showAlert(error.localizedDescription, onViewController: self)
    }
    
    
    
    //UIWebView
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let js = "function deleteEle(){ var tag =  document.getElementsByClassName(\"aw-upload-img-list\")[0];tag.parentNode.removeChild(tag);}"
        webView.stringByEvaluatingJavaScript(from: js)
        webView.stringByEvaluatingJavaScript(from: "deleteEle()")
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
}
