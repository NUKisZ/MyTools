//
//  FirstViewController.swift
//  MyTools
//
//  Created by zhangk on 17/3/23.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
class FirstViewController: TableViewBaseController {

    
    var label:UILabel{
        let l = ZKTools.createLabel(CGRect(x: 0, y: 64, width: 100, height: 40), title: "label", textAlignment: nil, font: nil, textColor: UIColor.red)
        return l
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.isTranslucent=false
        automaticallyAdjustsScrollViewInsets=false
        NotificationCenter.default.addObserver(self, selector: #selector(changeNetWorking(n:)), name: NSNotification.Name(kNetworkReachabilityChangedNotification), object: nil)
        //fixItem 用于消除左(右)边空隙，要不然按钮顶不到最前面
        let fixItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixItem.width = -10
        let netItem = UIBarButtonItem(title: "网络", style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [fixItem,netItem]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
//        let target = navigationController?.interactivePopGestureRecognizer?.delegate
//        let pan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
//        pan.delegate = self
//        view.addGestureRecognizer(pan)
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        //view.addSubview(label)
        creatADView()
        //createSubViews()
        createTableView(frame: CGRect(x: 0, y: 64, w: kScreenWidth, h: kScreenHeight-64), style: .plain, separatorStyle: .none)
        dataArray = ["全屏返回测试","缓存大小","下载界面","WebView","选择图片","多种字体","获取手机验证码","二维码生成","二维码扫描","轮播图","监听照片库变化","视频截图"]
//        navigationController?.setNavigationBarHidden(true, animated: false)
        //去空格
        let str = "  adf aase  werwer wr w wer wr qw r  w"
        print(str)
        let str1 = str.replacingOccurrences(of: " ", with: "")
        print(str1)
        let arr = ["aa","cc","bb"]
        let b = arr.sorted { (a, b) -> Bool in
            return a < b
        }
        print(b)
        let des:NSString = "123"
        let dese = des.encrypt()
        print(dese as Any)
        let base = Base64.decode("123")
        print(base as Any)
        let str123 = dese?.base64
        print(str123 as Any)
    }
    @objc private func changeNetWorking(n:NSNotification){
        if (n.object is NetworkReachabilityManager.NetworkReachabilityStatus){
            let reach = n.object as! NetworkReachabilityManager.NetworkReachabilityStatus
            var status = ""
            switch reach {
            case .unknown:
                status = "未知的"
            case .notReachable:
                status = "不可用"
            case .reachable(.wwan):
                status = "移动网络"
            case .reachable(.ethernetOrWiFi):
                status = "WiFi"
            }
            let fixItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            fixItem.width = -10
            let netItem = UIBarButtonItem(title: status, style: .done, target: nil, action: nil)
            navigationItem.rightBarButtonItems = [fixItem,netItem]
        }
        
    }
    private func delay(delay:Double,closure:@escaping ()->()){
        DispatchQueue.main.asyncAfter(deadline: .now()+delay, execute: closure)
    }
    private func createSubViews(){
        let btn = ZKTools.createButton(CGRect.init(x: 0, y: 114, width: 80, height: 30), title: "清空缓存", imageName: nil, bgImageName: nil, target: self, action: #selector(cacheClick))
        view.addSubview(btn)
        let goBackVCBtn = UIButton(type: .system)
        view.addSubview(goBackVCBtn)
        goBackVCBtn.setTitle("全屏返回测试", for: .normal)
        goBackVCBtn.addTarget(self, action: #selector(goBackVCBtnAction), for: .touchUpInside)
        goBackVCBtn.snp.makeConstraints {
            [weak self]
            (make) in
            make.top.equalTo(btn.snp.bottom)
            make.left.equalTo((self?.view.snp.left)!)
            make.height.equalTo(20)
        }
        let downloadVCBtn = UIButton(type: .system)
        view.addSubview(downloadVCBtn)
        downloadVCBtn.snp.makeConstraints {
            [weak self]
            (make) in
            make.top.equalTo(goBackVCBtn.snp.bottom)
            make.left.equalTo((self?.view.snp.left)!)
            make.height.equalTo(20)
        }
        downloadVCBtn.setTitle("下载界面", for: .normal)
        downloadVCBtn.addTarget(self, action: #selector(downloadVCAction), for: .touchUpInside)
        let webViewBtn = UIButton(type: .system)
        view.addSubview(webViewBtn)
        webViewBtn.snp.makeConstraints {
            [weak self]
            (make) in
            make.top.equalTo(downloadVCBtn.snp.bottom)
            make.left.equalTo((self?.view.snp.left)!)
            make.height.equalTo(20)
            
        }
        webViewBtn.setTitle("WebView", for: .normal)
        webViewBtn.addTarget(self, action: #selector(webViewAction), for: .touchUpInside)
        let albumBtn = UIButton(type: .system)
        view.addSubview(albumBtn)
        albumBtn.setTitle("选择图片", for: .normal)
        albumBtn.addTarget(self, action: #selector(albumBtnAction), for: .touchUpInside)
        albumBtn.snp.makeConstraints {
            [weak self]
            (make) in
            make.top.equalTo(webViewBtn.snp.bottom)
            make.left.equalTo((self?.view.snp.left)!)
            make.height.equalTo(20)
            
        }
        albumBtn.uxy_ignoreEvent=false
        albumBtn.uxy_acceptEventInterval=2
        let accEventBtn = UIButton(type: .system)
        view.addSubview(accEventBtn)
        accEventBtn.snp.makeConstraints {
            [weak self]
            (make) in
            make.left.equalTo((self?.view.snp.left)!)
            make.top.equalTo(albumBtn.snp.bottom)
            make.height.equalTo(30)
        }
        accEventBtn.uxy_acceptEventInterval=2
        accEventBtn.addTarget(self, action: #selector(accEventBtnAction), for: .touchUpInside)
        accEventBtn.setTitle("SwiftRuntime", for: .normal)
        
    }
    @objc private func accEventBtnAction(){
        print("aaaa")
    }
    @objc fileprivate func albumBtnAction(){
//        let style = UIApplication.shared.statusBarStyle
//        if style == UIStatusBarStyle.default{
//            UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
//        }else{
//            UIApplication.shared.setStatusBarStyle(.default, animated: true)
//        }
//        delay(delay: 1) {
//            //            let alert = UIAlertView(title: "测试", message: "测试", delegate: nil, cancelButtonTitle: "取消")
//            //            alert.show()
//            let aalert = UIAlertController(title: "测试2", message: "测试2", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//            aalert.addAction(cancelAction)
//            aalert.show()
//        }
        
        let alert = LGAlertView(progressViewAndTitle: "测试", message: "测试", style: .alert, progressLabelText: "测试", buttonTitles: ["确定"], cancelButtonTitle: "取消", destructiveButtonTitle: nil)
        alert.isCancelOnTouch = false
        updateProgressWithAlertView(alertView: alert)
        alert.show(animated: false, completionHandler: nil)
        
    }
    private func updateProgressWithAlertView(alertView:LGAlertView){
        delay(delay: 0.02) {
            [weak self] in
            if(alertView.progress >= 1.0){
                alertView.dismiss()
            }else{
                var progress = alertView.progress+0.001
                
                if (progress > 1.0){
                    progress = 1.0
                }
                alertView.setProgress(progress, progressLabelText: NSString(format: "%.0f %%", progress*100) as String)
                self?.updateProgressWithAlertView(alertView: alertView)
            }
        }
    }
    @objc fileprivate func webViewAction(){
        let webVc = WebViewController()
        hidesBottomBarWhenPushed=true
        navigationController?.pushViewController(webVc, animated: true)
        hidesBottomBarWhenPushed=false
    }
    @objc fileprivate func downloadVCAction(){
        let downloadVC = DownloadTaskViewController()
        hidesBottomBarWhenPushed=true
        navigationController?.pushViewController(downloadVC, animated: true)
        hidesBottomBarWhenPushed=false
    }
    @objc fileprivate func goBackVCBtnAction(){
        let backVC = BackViewController()
        backVC.delegate = self
        
        navigationController?.pushViewController(backVC, animated: true)
    }
    @objc fileprivate func cacheClick(){
//        let flag = ADView.clear()
//        if flag {
//            ZKTools.alertViewCtroller(vc: self, title: "提示", message: "清除缓存成功", cancelActionTitle: nil, sureActionTitle: "确定", action: nil)
//        }
        //tableView回到第一行
        //tableView?.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .bottom, animated: true)
        let size = CacheTool.cacheSize
        ZKTools.alertViewCtroller(vc: self, title: "提示", message: size, cancelActionTitle: nil, sureActionTitle: "确定", action: nil)
    }
    @objc fileprivate func clickUIFontVC(){
        let vc = UIFontViewController()
        hidesBottomBarWhenPushed=true
        navigationController?.pushViewController(vc, animated: true)
        hidesBottomBarWhenPushed=false
        
    }
    
    @objc fileprivate func getPhoneCode(){
        let vc = PhoneCodeViewController()
        //导航栏消失
        vc.modalTransitionStyle = .partialCurl
        hidesBottomBarWhenPushed = true
        present(vc, animated: true, completion: nil)
        hidesBottomBarWhenPushed = false
        
        
    }
    
    @objc fileprivate func EFQRCode(){
        let vc = EFQRCodeViewController()
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        hidesBottomBarWhenPushed = false
    }
    @objc fileprivate func QRCodeScan(){
        let vc = SwiftScanViewController()
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        hidesBottomBarWhenPushed = false
    }
    @available(iOS 8.2, *)
    @objc fileprivate func cycleClick(){
        let vc = CycleViewController()
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        hidesBottomBarWhenPushed = false
    }
    @objc fileprivate func photoLibraryDidChange() {
        //监听照片库变化
        let vc = PhotoLibraryDidChangeViewController()
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        hidesBottomBarWhenPushed = false
        
    }
    @objc fileprivate func videoShotClick(){
        
        let vc = VideoShotViewController()
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        hidesBottomBarWhenPushed = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        download()
        //Info.plist 中添加 View controller-based status bar appearance : NO
        UIApplication.shared.setStatusBarStyle(.default, animated: animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
//        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//        navigationController?.navigationBar.isHidden = false
    }
    private func creatADView(){
        let kADModel = kUserDefaults.data(forKey: "ADModel")
        var model = ADModel()
        if kADModel == nil{
            model.adImageUrl = "https://www.uilucky.com/AppData/images/WechatIMG1.jpeg"
            model.adUrl = "https://uilucky.com/"
        }else{
            model = ADModel.parseJson(kADModel!)
        }
        let adView = ADView(frame: self.view.frame, imagedUrl: (model.adImageUrl)!, ad: (model.adUrl)!) {
            [weak self]
            (adUrl) in
            let adVC = ADViewController()
            adVC.adUrl = adUrl
            self?.navigationController?.pushViewController(adVC, animated: true)
        }
        adView.showTime = 5
        adView.show()
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(kNetworkReachabilityChangedNotification), object: nil)
    }
    private func download(){
        let download = ZKDownloader()
        download.delegate = self
        download.getWithUrl(kADUrl)
        download.type=1
        
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
// MARK: - ZKDownloaderDelegate
extension FirstViewController:ZKDownloaderDelegate{
    func downloader(_ download: ZKDownloader, didFailWithError error: NSError) {
        print(error)
    }
    func downloader(_ download: ZKDownloader, didFinishWithData data: Data?) {
        if download.type == 1 {
            //print(ZKTools.stringWithData(data: data!))
            kUserDefaults.set(data!, forKey: "ADModel")
            kUserDefaults.synchronize()
        }
    }
}
extension FirstViewController:BackViewControllerDelegate{
    func backTest(str: String) {
        print(str)
    }
}
// MARK: - TableViewDelegate
extension FirstViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID = "FirstViewControllerID"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: ID)
        }
        cell?.selectionStyle = .none
        cell?.textLabel?.text = dataArray[indexPath.row] as? String
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            goBackVCBtnAction()
            break
        case 1:
            cacheClick()
            break
        case 2:
            downloadVCAction()
        case 3:
            webViewAction()
        case 4:
            albumBtnAction()
        case 5:
            clickUIFontVC()
        case 6:
            getPhoneCode()
            //fallthrough穿透case
            //fallthrough
        case 7:
            EFQRCode()
        case 8:
            QRCodeScan()
        case 9:
            if #available(iOS 8.2, *) {
                cycleClick()
            }
        case 10:
            photoLibraryDidChange()
        case 11:
            videoShotClick()
        default:
            print("fallthrough")
            break
        }
    }
}
extension FirstViewController:UIGestureRecognizerDelegate{
    //是否允许手势
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        
//        if(gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer){
//            //只有二级以及以下的页面允许手势返回
//            return (self.navigationController?.viewControllers.count)! > 1
//        }
//        return true
//    }
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        if(childViewControllers.count == 1){
//            return false
//        }
//        return true
//    }
}
