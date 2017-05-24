//
//  MyTools.swift
//  MengWuShe
//
//  Created by zhangk on 16/10/17.
//  Copyright © 2016年 zhangk. All rights reserved.
//

import UIKit
//判断真机还是模拟器
struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

extension UIColor{
    class func colorWithRGBA(red r:CGFloat,green g:CGFloat,blue b:CGFloat, alpha a:CGFloat)->UIColor {
        //返回一个颜色
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/1.0)
    }
    class func colorWithHexStringAndAlpha (hex: String, alpha:CGFloat) -> UIColor {
        //接收到十六进制的颜色字符串和透明度,返回一个颜色
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        let rString = (cString as NSString).substring(to: 2)
        
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
        
    }
}

class ZKTools: NSObject {
    
    class func colorWithRGBA(red r:CGFloat,green g:CGFloat,blue b:CGFloat, alpha a:CGFloat)->UIColor {
        //返回一个颜色
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/1.0)
    }
    class func colorWithHexString (hex: String) -> UIColor {
        //接收到十六进制的颜色字符串,返回一个颜色
        //var cs:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        let rString = (cString as NSString).substring(to: 2)
        
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
        
        
    }
    class func colorWithHexStringAndAlpha (hex: String, alpha:CGFloat) -> UIColor {
        //接收到十六进制的颜色字符串和透明度,返回一个颜色
        //var cs:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        let rString = (cString as NSString).substring(to: 2)
        
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
        
    }
    

    class func createButton(_ frame:CGRect,title:String?,imageName:String?,bgImageName:String?,target:AnyObject?,action:Selector?)->UIButton {
        let btn = UIButton(type: .custom)
        btn.frame = frame
        if let btnTitle = title{
            btn.setTitle(btnTitle, for: UIControlState())
            btn.setTitleColor(UIColor.black, for: .normal)
        }
        if let btnImageName = imageName{
            btn.setImage(UIImage(named: btnImageName), for: .normal)
        }
        
        if let btnBgImageName = bgImageName{
            btn.setBackgroundImage(UIImage(named: btnBgImageName), for: .normal)
        }
        if let btnTarget = target {
            if let btnAction = action{
                btn.addTarget(btnTarget, action: btnAction, for: .touchUpInside)
            }
        }
        return btn
    }
    
    class func createLabel(_ frame:CGRect,title:String?,textAlignment:NSTextAlignment?,font:UIFont?,textColor:UIColor?)->UILabel{
        let label = UILabel(frame: frame)
        if let labelTitle = title{
            label.text = labelTitle
        }
        if let labelFont = font{
            label.font = labelFont
        }
        if let labelTextColor = textColor{
            label.textColor = labelTextColor
        }
        if let labelTextAlignment = textAlignment{
            label.textAlignment = labelTextAlignment
        }
        return label
    }
    
    
    class func createImageView(_ frame:CGRect,imageName:String?,imageUrl:String?)->UIImageView{
        let imageView = UIImageView(frame: frame)
        if let name = imageName{
            imageView.image = UIImage(named: name)
        }
        return imageView
    }
    
    class func alertViewCtroller(vc:UIViewController,title:String?,message:String?,cancelActionTitle:String?,sureActionTitle:String,action:((UIAlertAction)->Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let sureAction = UIAlertAction(title: sureActionTitle, style: .default, handler: action)
        _ = UIAlertAction(title: "", style: .cancel, handler: action)
        alert.addAction(sureAction)
        if let cancelString = cancelActionTitle{
            let cancelAction = UIAlertAction(title: cancelString, style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        
        vc.present(alert, animated: true, completion: nil)
    }
    class func showAlert(_ msg:String,onViewController vc :UIViewController){
        
        let alert = UIAlertController(title: "提示", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
        
    }
    #if false
    class func weiXinLogin(vc:UIViewController){
            let req = SendAuthReq()
            req.scope = "snsapi_userinfo"
            req.state = "code"
            WXApi.send(req)

    }
    class func login(vc:UIViewController){
        
        
        //检测手机有没有安装微信
        //1.在info.plist中把weixin和wechat加入白名单中
        //2.在app中加入下面判断isWXAppInstalled是否安装微信
        //3.isWXAppSupportApi当前版本是否支持
        if(!WXApi.isWXAppInstalled())&&(!WXApi.isWXAppSupport()){
            //检测到手机没有安装微信
            
            let alert = UIAlertController(title: "登录", message: "您还没有登陆,是否登录?", preferredStyle: .alert)
            let sureAction = UIAlertAction(title: "登录", style: .default) { (alert) in
                //帐号登陆
                let loginCtrl = LoginViewController()
                vc.hidesBottomBarWhenPushed = true
                loginCtrl.navigationController?.navigationBar.isHidden = false
                vc.navigationController?.pushViewController(loginCtrl, animated: true)
                vc.hidesBottomBarWhenPushed = false
                
            }
            alert.addAction(sureAction)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            vc.present(alert, animated: true, completion: nil)
            
            
        }else{
            //手机已安装微信并且版本支持
            let alert = UIAlertController(title: "登录", message: "您还没有登陆,是否登录?", preferredStyle: .alert)
            let sureAction = UIAlertAction(title: "登录", style: .default) { (alert) in
                //微信登录
                let req = SendAuthReq()
                req.scope = "snsapi_userinfo"
                req.state = "code"
                WXApi.send(req)
            }
            alert.addAction(sureAction)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            vc.present(alert, animated: true, completion: nil)
        }
        
    }
    #endif
    
    
    #if false
    //分享
    class func shareClick(vc:UIViewController,title:String,desc:String,imageurl:String,urlString:String){
        let aSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        var t:String = ""
        var d:String = ""
        var i:String = ""
        if title == "title"{
            t = "分享"
        }else{
            t = MyTools.urlEncodingToString(str: title)
        }
        if desc == "desc"{
            d = "萌物社分享"
        }else{
            d = MyTools.urlEncodingToString(str: desc)
        }
        if imageurl == "imageurl"{
            i = MWSShareImageUrl
        }else{
            i = imageurl
        }
        
    
        let weChatAction = UIAlertAction(title: "分享至微信", style: .default) {
            (alert) in
            let alert = UIAlertController(title: t, message: d, preferredStyle: .alert)
            let friendsAction = UIAlertAction(title: "分享给好友", style: .default) { (alert) in
                let message = WXMediaMessage()
                message.title = t
                message.description = d
                
                message.setThumbImage(UIImage(named: "appIcon"))
                let webPageObject = WXWebpageObject()
                webPageObject.webpageUrl = urlString
                message.mediaObject = webPageObject
                
                let req = SendMessageToWXReq()
                req.message = message
                req.bText = false
                req.scene = Int32(UInt32(WXSceneSession.rawValue))
                
                WXApi.send(req)
            }
            alert.addAction(friendsAction)
            let momentsAction = UIAlertAction(title: "分享到朋友圈", style: .default) { (alert) in
                let message = WXMediaMessage()
                message.title = t
                message.description = d
                message.setThumbImage(UIImage(named: "appIcon"))
                let webPageObject = WXWebpageObject()
                webPageObject.webpageUrl = urlString
                message.mediaObject = webPageObject
                
                let req = SendMessageToWXReq()
                req.message = message
                req.bText = false
                req.scene = Int32(UInt32(WXSceneTimeline.rawValue))
                WXApi.send(req)
            }
            alert.addAction(momentsAction)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            vc.present(alert, animated: true, completion: nil)
            
        }
        aSheet.addAction(weChatAction)
        let tencent = UIAlertAction(title: "分享至QQ", style: .default) { (alert) in
            
            
            shareTencent(urlString: urlString, title: t, desc: d, imageUrl: i)
        }
        aSheet.addAction(tencent)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        aSheet.addAction(cancel)
        vc.present(aSheet, animated: true, completion: nil)
        
        
    }
    //分享到QQ好友
    class func shareTencent(urlString:String,title:String,desc:String,imageUrl:String){

        let shareUrl = QQApiURLObject(url: URL(string:urlString), title: title, description: desc, previewImageURL: URL(string:imageUrl), targetContentType: QQApiURLTargetTypeNews)
        let req = SendMessageToQQReq(content: shareUrl)
        QQApiInterface.send(req)
        
    }
    
    //微信支付
    class func payWithWeiChat(partnerId:String,prepayId:String,package:String="Sign=WXPay",nonceStr:String,timeStamp:String,sign:String){
        
        let request = PayReq()
        request.partnerId = partnerId
        request.prepayId = prepayId
        request.package = package
        request.nonceStr = nonceStr
        request.timeStamp = UInt32(timeStamp)!
        request.sign = sign
        WXApi.send(request)
        
    }
    #endif
    //data编码转字符串
    class func stringWithData(data:Data)->String{
        
        let string = (NSString(data: data, encoding: String.Encoding.utf8.rawValue))! as String
        return string
    }
    
    
    //url编码转字符串
    class func urlEncodingToString (str:String)->String{
        let string = NSString(string: str).removingPercentEncoding
        return string!
    }
    //字符串转url编码
    class func stringToUrlEncoding(string:String)->String?{
        return string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    class func httpToHttps(string:String)->String{
        var str:String=string
        if string.hasPrefix("http://"){
            let arr = string.components(separatedBy: "http://")
            str = "https://" + arr[1]
        }
        return str
    }
    
    
    //大图片得到小图片
    class func getSamllImageWithBigImage(bigImage:UIImage,sizeChange:CGSize,compressionQuality:CGFloat=0.1,name:String="samllImage.jpeg")->Data?{
//        var imageData = Data()
        var image = bigImage
//        imageData = UIImagePNGRepresentation(image)!
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, false, 0.0)
        
        image.draw(in: CGRect(origin: CGPoint(x:0.0,y:0.0), size: sizeChange))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndPDFContext()
        let imageSmall = UIImageJPEGRepresentation(image, compressionQuality)
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        let path = docDir?.appendingFormat("/%@", name)
        let url = URL(fileURLWithPath: path!)
        print(path ?? "path nil")
        do{
            try imageSmall?.write(to: url, options: NSData.WritingOptions.atomicWrite)
            
            
            
        }catch{
            print(error)
        }
        return imageSmall
    }
    
    //检测一个手机号
    class func testPhoneNumber(phoneNumber:String)->Bool{
        
        let str = "^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$"
        
        let p = NSPredicate(format: "self matches %@", str)
        
        
        let ret = p.evaluate(with: phoneNumber)
        
        
        if (ret && (phoneNumber.characters.count) == 11){
                //是手机号
            return true
                
                
        }else{
            return false
                
        }
            
        
        
    }
    class func stringToMD5(string:String)->String {
        let str = string.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }
    
    
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone9,1":                               return "iPhone 7"
        case "iPhone9,2":                               return "iPhone 7 Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}
func UIImage2CGimage(_ image: UIImage?) -> CGImage? {
    if let tryImage = image, let tryCIImage = CIImage(image: tryImage) {
        return CIContext().createCGImage(tryCIImage, from: tryCIImage.extent)
    }
    return nil
}
