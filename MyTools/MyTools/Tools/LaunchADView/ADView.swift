//
//  ADView.swift
//  LaunchAD
//
//  Created by zhangk on 17/1/9.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

private let kAdImageName = "adImageNmae"
private let kAdUrl = "adUrl"
class ADView: UIView {

    open var showTime:Int=5
    private var adView=UIImageView()
    private var countBtn=UIButton()
    private var countTimer:Timer?
    private var count:Int!
    private var imPath:String!
    private var imgUrl:String!
    private var adUrl:String!
    private var clickAdUrl:String!
    private var clickImg:((String) -> Void)!
    init(frame: CGRect,imagedUrl:String,ad:String,clikImage:@escaping (String)->Void) {
        super.init(frame: frame)
        
        clickImg = clikImage
        imgUrl = imagedUrl
        adUrl = ad
        adView = UIImageView.init(frame: frame)
        adView.isUserInteractionEnabled = true
        adView.contentMode = UIViewContentMode.scaleAspectFill
        adView.clipsToBounds = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(pushToAd))
        adView.addGestureRecognizer(tap)
        let btnW = 60
        let btnH = 30
        
        countBtn = UIButton.init(frame: CGRect(x: Int(kScreenWidth) - btnW - 24, y: btnH, width: btnW, height: btnH))
        countBtn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        countBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        countBtn.setTitleColor(UIColor.white, for: .normal)
        countBtn.backgroundColor = UIColor(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 0.6)
        countBtn.layer.cornerRadius = 4
        addSubview(adView)
        addSubview(countBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public class func clear()->Bool{
        kUserDefaults.removeObject(forKey: kAdUrl)
        kUserDefaults.removeObject(forKey: kAdImageName)
        kUserDefaults.removeObject(forKey: "ADModel")
        kUserDefaults.synchronize()
        let flag = CacheTool.clearCache()
        if kUserDefaults.value(forKey: kAdUrl)==nil && kUserDefaults.value(forKey: kAdImageName) == nil && flag{
            return true
        }
        return false
    }
    
    func show(){
        if imageExist(){
            count = showTime
            countBtn.setTitle(String(format: "跳过%@", "\(count!)"), for: .normal)
            
            adView.image = UIImage.init(contentsOfFile: imPath)
            clickAdUrl = kUserDefaults.value(forKey: kAdUrl) as! String
            startTimer()
            
            let window = UIApplication.shared.keyWindow!
            window.addSubview(self)
        }
        setNewADImgUrl(imgUrl: imgUrl)
        
    }
    private func imageExist()->Bool{
        if kUserDefaults.value(forKey: kAdImageName) == nil || kUserDefaults.value(forKey: kAdUrl) == nil{
            return false
        }
        imPath = getFilePathWithImageName(imageName: kUserDefaults.value(forKey: kAdImageName)as! String)
        let fileManager = FileManager.default
        let isExist = fileManager.fileExists(atPath: imPath)
        return isExist
    }
    @objc private func countDown(){
        count=count-1
        let title = String(format: "跳过%@", "\(count!)")
        countBtn.setTitle(title, for: .normal)
        if count == 0{
            dismiss()
        }
        
    }
    @objc private func pushToAd(){
        if (clickAdUrl != nil){
            clickImg(clickAdUrl)
            dismiss()
        }
        
    }
    @objc private func dismiss(){
        countTimer?.invalidate()
        countTimer = nil
        UIView.animate(withDuration: 0.3, animations: {
            [weak self] in
            
            self?.alpha = 0
            }) {
                [weak self]
                (finished) in
                self?.removeFromSuperview()
        }
    }
    private func setNewADImgUrl(imgUrl:String){
        let imgName = NSString(string: imgUrl).lastPathComponent
        let filePath = getFilePathWithImageName(imageName: imgName)
        let fileManager = FileManager.default
        let isExist = fileManager.fileExists(atPath: filePath)
        if (!isExist){
            downloadAdImageWithUrl(imageUrl: imgUrl, imageName: imgName)
        }
        
    }
    private func downloadAdImageWithUrl(imageUrl:String,imageName:String){
        DispatchQueue.global(qos: .default).async {
            
            //下载
            let url = URL(string: imageUrl)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            let filePath = self.getFilePathWithImageName(imageName: imageName)
            do{
                print(filePath)
                try UIImagePNGRepresentation(image!)?.write(to: URL(fileURLWithPath: filePath), options: .atomic)
                print("保存成功")
                self.deleteOldImage()
                kUserDefaults.setValue(imageName, forKey: kAdImageName)
                kUserDefaults.setValue(self.adUrl, forKey: kAdUrl)
                kUserDefaults.synchronize()
                
            }catch{
                print(error)
                print("保存失败")
            }
            
        }
    }
    private func startTimer(){
        count = showTime
        if (countTimer == nil){
            countTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        }
        RunLoop.main.add(countTimer!, forMode: .commonModes)
    }
    private func getFilePathWithImageName(imageName:String)->String{
        let cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let imagePath = cachesPath!+"/"+imageName
        return imagePath
    }
    private func deleteOldImage(){
        let imageName = kUserDefaults.value(forKey: kAdImageName)
        if ((imageName) != nil){
            let imgPath = getFilePathWithImageName(imageName: imageName as! String)
            let fileManager = FileManager.default
            do {
                try fileManager.removeItem(atPath: imgPath)
            } catch  {
                
            }
        }
        
    }

}
