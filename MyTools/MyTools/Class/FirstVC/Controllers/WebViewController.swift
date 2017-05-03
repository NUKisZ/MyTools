//
//  WebViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/4/25.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
import JavaScriptCore

class WebViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createWebView()
        
    }
    func createWebView(){
        navigationController?.automaticallyAdjustsScrollViewInsets=false
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-64))
        view.addSubview(webView)
        let request = URLRequest(url: URL(string: "https://www.baidu.com")!)
        webView.loadRequest(request)
        webView.delegate = self
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
extension WebViewController:UIWebViewDelegate{
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
