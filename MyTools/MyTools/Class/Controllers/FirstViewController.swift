//
//  FirstViewController.swift
//  MyTools
//
//  Created by zhangk on 17/3/23.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController {

    var label:UILabel{
        let l = ZKTools.createLabel(CGRect(x: 0, y: 70, width: 100, height: 40), title: "label", textAlignment: nil, font: nil, textColor: UIColor.red)
        return l
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(label)
        creatADView()
        let btn = ZKTools.createButton(CGRect.init(x: 0, y: 120, width: 80, height: 30), title: "清空缓存", imageName: nil, bgImageName: nil, target: self, action: #selector(cacheClick))
        view.addSubview(btn)
        
    }
    @objc private func cacheClick(){
        let flag = ADView.clear()
        if flag {
            ZKTools.alertViewCtroller(vc: self, title: "提示", message: "清除缓存成功", cancelActionTitle: nil, sureActionTitle: "确定", action: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        download()
        
    }
    func creatADView(){
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
        adView.showTime = 15
        adView.show()
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
extension FirstViewController:ZKDownloaderDelegate{
    func downloader(_ download: ZKDownloader, didFailWithError error: NSError) {
        print(error)
    }
    func downloader(_ download: ZKDownloader, didFinishWithData data: Data?) {
        if download.type == 1 {
            print(ZKTools.stringWithData(data: data!))
            let u = UserDefaults.standard
            u.set(data!, forKey: "ADModel")
            u.synchronize()
        }
    }
}
