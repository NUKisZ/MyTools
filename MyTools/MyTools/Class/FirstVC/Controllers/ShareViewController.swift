//
//  ShareViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/7/21.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKLoginKit
class ShareViewController: BaseViewController {

    var shareType:SSDKPlatformType!
    override func viewDidLoad() {
        super.viewDidLoad()

        let shareBtn = ZKTools.createButton(CGRect(x: 20, y: 70, w: 50, h: 30), title: "分享", imageName: nil, bgImageName: nil, target: self, action: #selector(shareAction))
        view.addSubview(shareBtn)
        
        let fbBtn = ZKTools.createButton(CGRect(x: 100, y: 70, width: 100, height: 30), title: "FaceBook", imageName: nil, bgImageName: nil, target: self, action: #selector(fbAction))
        view.addSubview(fbBtn)
        
        let FBMessageBtn = ZKTools.createButton(CGRect(x: 20, y: 140, width: 100, height: 30), title: "Message", imageName: nil, bgImageName: nil, target: self, action: #selector(messageAction))
        view.addSubview(FBMessageBtn)
        let buttonWidth:CGFloat = 50
        let fbme = FBSDKMessengerShareButton.circularButton(with: .blue, width: buttonWidth)
        fbme?.addTarget(self, action: #selector(messageAction), for: .touchUpInside)
        view.addSubview(fbme!)

        
        let loginButton = FBSDKLoginButton()
        
        loginButton.center = view.center
        loginButton.readPermissions=["public_profile","email","user_friends"]
        loginButton.delegate = self
        view.addSubview(loginButton)
        if((FBSDKAccessToken.current()) != nil){
            print("用户已经登陆")
            if let token = FBSDKAccessToken.current(){
                print(token)
                
                print(token.appID)
                print(token.userID )
                print(token.tokenString)
                
            }
            
            
        }
        
    }
    @objc private func messageAction(){
        let image = UIImage(named: "swift.png")
        FBSDKMessengerSharer.share(image, with: nil)
    }

    @objc private func fbAction(){
        let content = FBSDKShareLinkContent()
        content.contentURL = URL(string: "https://www.uilucky.com")
        
//        let dialog = FBSDKShareDialog()
//        dialog.fromViewController = self;
//        dialog.shareContent = content
//        dialog.mode = FBSDKShareDialogMode.shareSheet
//        dialog.show()
        FBSDKShareDialog.show(from: self, with: content, delegate: nil)
        
        
    
    
    }
    @objc private func shareAction(){
        
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: "分享内容",
                                          images : UIImage(named: "swift.png"),
                                          url : NSURL(string:"http://mob.com") as URL!,
                                          title : "分享标题",
                                          type : SSDKContentType.image)
        
        
        
        let alertVC = UIAlertController(title: "分享", message: nil, preferredStyle: .actionSheet)
        let faceAction = UIAlertAction(title: "FaceBook", style: .default) {
            [weak self]
            (action) in
            self?.shareType = .typeFacebook
            self?.share(shareType: (self?.shareType)!, shareParames: shareParames)
        }
        let twitterAction = UIAlertAction(title: "Twitter", style: .default) {
            [weak self]
            (action) in
            self?.shareType = .typeTwitter
            self?.share(shareType: (self?.shareType)!, shareParames: shareParames)
        }
        let youtubeAction = UIAlertAction(title: "YouTube", style: .default) {
            [weak self]
            (action) in
            self?.shareType = .typeYouTube
            self?.share(shareType: (self?.shareType)!, shareParames: shareParames)
            
        }
        let canceAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertVC.addAction(faceAction)
        alertVC.addAction(twitterAction)
        alertVC.addAction(youtubeAction)
        
        alertVC.addAction(canceAction)
        present(alertVC, animated: true, completion: nil)
        
    }
    private func share(shareType:SSDKPlatformType, shareParames:NSMutableDictionary){
        //2.进行分享
        ShareSDK.share(shareType, parameters: shareParames) {
            [weak self]
            (state : SSDKResponseState, nil, entity : SSDKContentEntity?, error :Error?) in
            
            switch state{
                
            case SSDKResponseState.success:
                MBToast.showToast(showView: (self?.view)!, toast: "分享成功")
                print("分享成功")
            case SSDKResponseState.fail:
                print("授权失败,错误描述:\(String(describing: error))")
            case SSDKResponseState.cancel:
                MBToast.showToast(toast: "分享取消")
                print("操作取消")
                
            default:
                break
            }
            
        }
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

extension ShareViewController:FBSDKLoginButtonDelegate{
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print(result)
        print(result.token.userID)
        print(result.token.appID)
        print(result.token.tokenString)
        print(result.grantedPermissions)
        print(result.declinedPermissions)
        print(result.isCancelled)
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("退出")
    }
}
