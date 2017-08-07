//
//  WKWebViewBaseViewController.swift
//  MengWuShe
//
//  Created by zhangk on 16/11/25.
//  Copyright © 2016年 zhangk. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewBaseViewController: BaseViewController {
    
    
    var wkWebView:WKWebView?
    lazy var progressView:UIProgressView = UIProgressView(frame: CGRect(x: 0, y: 64, w: kScreenWidth, h: 2))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        deinitWebView()
    }
    
    func createWKWebView(urlString:String){
        navigationController?.automaticallyAdjustsScrollViewInsets = false
        // 创建配置
        let theConfiguration = WKWebViewConfiguration()
        theConfiguration.preferences = WKPreferences.init()
        theConfiguration.preferences.minimumFontSize = 0
        theConfiguration.preferences.javaScriptEnabled = true
        // 创建UserContentController（提供JavaScript向webView发送消息的方法）
        let userContentController = WKUserContentController()
        // 将UserConttentController设置到配置文件
        theConfiguration.userContentController = userContentController
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        //配置当前ViewController为MessageHandler，需要服从WKScriptMessageHandler协议，如果出现警告⚠️，请检查是否服从了这个协议。
        theConfiguration.userContentController.add(self, name: "interOp")
        wkWebView = WKWebView(frame: CGRect(x: 0, y: 66, width: kScreenWidth, height: kScreenHeight-64-2), configuration: theConfiguration)
        
        wkWebView?.scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
        wkWebView?.isOpaque = false
        wkWebView?.backgroundColor = UIColor.clear
        wkWebView?.allowsBackForwardNavigationGestures = true
        
        let url = URL(string:urlString)
        //let request = URLRequest(url: url!)
        let request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy(rawValue: UInt(1))!, timeoutInterval: 15)
        let _ = wkWebView?.load(request)
        
        wkWebView?.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            [weak self] in
            self?.progressView.isHidden = false
            let _ = self?.wkWebView?.load(request)
            for subView in (self?.wkWebView?.subviews)!{
                if subView.tag == 151{
                    subView.removeFromSuperview()
                }
                if subView.tag == 150{
                    subView.removeFromSuperview()
                }
            }
            
            })
        wkWebView?.backgroundColor = UIColor.white
        wkWebView?.uiDelegate = self
        wkWebView?.navigationDelegate = self
        wkWebView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        
        view.addSubview(wkWebView!)
    }
    func createProgressView(){
        progressView.backgroundColor = UIColor.gray
        progressView.tintColor = UIColor.blue
        view.addSubview(progressView)
        view.bringSubview(toFront: progressView)
    }
    func createGoBack(){
        let backBtn = ZKTools.createButton(CGRect(x: 0, y: 0, width: 20, height: 20), title: nil, imageName: "goback", bgImageName: nil, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
    func backAction(){
        deinitWebView()
        let _ = navigationController?.popViewController(animated: true)
        
    }
    func deinitWebView(){
        wkWebView?.removeObserver(self, forKeyPath: "estimatedProgress")
        //上面将当前ViewController设置为MessageHandler之后需要在当前ViewController销毁前将其移除，否则会造成内存泄漏。
        wkWebView?.configuration.userContentController.removeScriptMessageHandler(forName: "interOp")
        wkWebView?.uiDelegate = nil
        wkWebView?.navigationDelegate = nil
        wkWebView = nil
        
    }
    func createTimeOutView(){
        let imageView = UIImageView(image: UIImage(named: "netFail.jpg"))
        wkWebView?.addSubview(imageView)
        imageView.snp.makeConstraints({
            [weak self]
            (make) in
            make.centerX.equalTo((self?.wkWebView?.snp.centerX)!)
            make.top.equalTo((self?.wkWebView?.snp.top)!).offset(120)
            make.width.equalTo(116)
            make.height.equalTo(116)
            })
        imageView.tag = 150
        let label = UILabel()
        wkWebView?.addSubview(label)
        label.snp.makeConstraints({
            [weak self]
            (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalTo((self?.wkWebView?.snp.centerX)!)
            make.height.equalTo(20)
            })
        label.text = "网络错误,请尝试下拉刷新"
        
        label.tag = 151
        let btn = UIButton(type: .custom)
        wkWebView?.addSubview(btn)
        btn.snp.makeConstraints({
            [weak self]
            (make) in
            make.centerX.equalTo((self?.wkWebView?.snp.centerX)!)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.height.equalTo(30)
            })
        btn.tag = 152
        btn.setTitle("查看解决方案", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(TimedOutAction), for: .touchUpInside)
    }
    private func removeTimeOutView(){
        for subView in (wkWebView?.subviews)!{
            
            if subView.tag == 150{
                subView.removeFromSuperview()
            }
            if subView.tag == 151{
                subView.removeFromSuperview()
            }
            if subView.tag == 152{
                subView.removeFromSuperview()
            }
        }
    }
    func TimedOutAction(){
        print("TimedOutAction")
//        let timeOutCtrl = TimeOutViewController()
//        hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(timeOutCtrl, animated: true)
//        hidesBottomBarWhenPushed = false
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath=="estimatedProgress"){
            print(wkWebView?.estimatedProgress as Any)
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.2, animations: {
                        [weak self] in
                        self?.progressView.progress = Float ((self?.wkWebView?.estimatedProgress)!)
                    })
                }
            }
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension WKWebViewBaseViewController:WKScriptMessageHandler{
    //配置当前ViewController为MessageHandler，需要服从WKScriptMessageHandler协议，如果出现警告⚠️，请检查是否服从了这个协议。
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("父类的userContentController")
        print(message.body)
        // 判断是否是调用原生的
        if("interOp"==message.name){
            // 判断message的内容，然后做相应的操作
            if(""==message.body as! String){
                
            }
        }
    }
}
extension WKWebViewBaseViewController:WKNavigationDelegate,WKUIDelegate{
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("父类的didFailProvisionalNavigation")
        
        ProgressHUD.hideAfterFailOnView(view)
        
        print(error.localizedDescription)
        if (error.localizedDescription == "The request timed out.") || (error.localizedDescription == "The Internet connection appears to be offline."){
            print("超时")
            let _ = wkWebView?.loadHTMLString("", baseURL: nil)
            webView.scrollView.mj_header.endRefreshing()
        }
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("父类didFail:\(error)")
        webView.scrollView.mj_header.endRefreshing()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("父类的didFinish")
        webView.scrollView.mj_header.endRefreshing()
        
        DispatchQueue.main.async {
            [weak self]in
            UIView.animate(withDuration: 0.2, animations: {
                self?.wkWebView?.frame = CGRect(x: 0, y: 64, w: kScreenWidth, h: kScreenHeight-64)
                self?.progressView.isHidden = true
            }, completion: nil)
        }
        //webView.title                //web的title
        //webView.evaluateJavaScript("javascript:refreshmessage()", completionHandler: nil) //执行js方法
        
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //点击wkWebView上面的控件的时候.
        //与H5交互的时候
        let urlStr = String(describing: navigationAction.request)
        print("父类的decidePolicyFor")
        print(urlStr)
        decisionHandler(.allow)
    }
    
    
}

