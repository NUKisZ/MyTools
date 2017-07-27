//
//  YouTubeViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/7/26.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class YouTubeViewController: MOBPlatformViewController {

    var shareParameters = NSMutableDictionary()
    var httpServiceModel:SSDKHttpServiceModel!
    override func viewDidLoad() {
        super.viewDidLoad()

//        let shareBtn = ZKTools.createButton(CGRect(x: 20, y: 70, w: 50, h: 30), title: "分享", imageName: nil, bgImageName: nil, target: self, action: #selector(shareAction))
//        view.addSubview(shareBtn)
        
        platformType = .typeYouTube
        shareIconArray = ["videoIcon","videoIcon"]
        shareTypeArray = ["视频","视频 上传进度"]
        selectorNameArray = ["shareVideo","shareVideoUploadProgress"]
        let filePath = Bundle.main.path(forResource: "cat", ofType: "mp4")
        print(filePath)
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "cat", ofType: "mp4")!)
        //let url = URL(string: "http://eshare.vod.otvcloud.com/otv/yfy/D/11/03/00000409445/409445_2300k_1920x1080.mp4")
        shareParameters.ssdkSetupShareParams(byText: nil, images: nil, url: url, title: nil, type: SSDKContentType.video)
        
    }

    func shareVideo(){
        shareWithParameters(parameters: shareParameters)
        print("开始上传")
    }
    func shareVideoUploadProgress(){
        let parameters = NSMutableDictionary()
        let alert = LGAlertView(progressViewAndTitle: "测试", message: "测试", style: .alert, progressLabelText: "测试", buttonTitles: ["确定"], cancelButtonTitle: "取消", destructiveButtonTitle: nil)
        alert.isCancelOnTouch = true
        alert.show(animated: false, completionHandler: nil)
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "cat", ofType: "mp4")!)
        parameters.ssdkSetupShareParams(byText: "Share SDK", images: nil, url: url, title: nil, type: SSDKContentType.video)
        ShareSDK.share(platformType, parameters: parameters) {
            [weak self]
            (state, userData, contentEntity, error) in
            var titel = ""
            switch(state){
                case .beginUPLoad:
                    self?.httpServiceModel = SSDKVideoUploadCenter.shareInstance().uploadProgress(with: (self?.platformType)!, fileURL: url, tag: "", progressEvent: { (totalBytes, loadedBytes) in
                        let temp = CGFloat(loadedBytes)/CGFloat(totalBytes)
                        print(temp)
                        self?.updateProgressWithAlertView(alertView: alert, progress: temp)
                    })
            case .success:
                print("分享成功")
                titel = "分享成功"
            case .fail:
                print("失败")
                titel = "分享失败"
            case .cancel:
                print("取消")
                titel = "分享取消"
            default:
                break
            }
            ZKTools.alertViewCtroller(vc: self!, title: titel, message: nil, cancelActionTitle: "取消", sureActionTitle: "确定", action: nil)
            
        }
    }
    
    private func updateProgressWithAlertView(alertView:LGAlertView,progress:CGFloat){
        if(alertView.progress >= 1.0){
            alertView.dismiss()
        }else{
            var progress = alertView.progress+0.001
            
            if (progress > 1.0){
                progress = 1.0
            }
            alertView.setProgress(progress, progressLabelText: NSString(format: "%.0f %%", progress*100) as String)
        }
        
    }
    func showLoading(){
        print("loading")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc private func shareAction(){
        
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: "分享内容",
                                          images : UIImage(named: "swift.png"),
                                          url : NSURL(string:"http://mob.com") as URL!,
                                          title : "分享标题",
                                          type : SSDKContentType.image)
        
        
        
        let alertVC = UIAlertController(title: "分享", message: nil, preferredStyle: .actionSheet)
        
        let youtubeAction = UIAlertAction(title: "YouTube", style: .default) {
            [weak self]
            (action) in
            
            
        }
        let canceAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alertVC.addAction(youtubeAction)
        
        alertVC.addAction(canceAction)
        present(alertVC, animated: true, completion: nil)
        
    }
    
    

}
