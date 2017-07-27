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

    var tableView:UITableView!
    var model:FBFriendsModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        createTableView()
        
        let fbBtn = ZKTools.createButton(CGRect(x: 100, y: 70, width: 100, height: 30), title: "FaceBook", imageName: nil, bgImageName: nil, target: self, action: #selector(fbAction))
        view.addSubview(fbBtn)
        
        let FBMessageBtn = ZKTools.createButton(CGRect(x: 20, y: 140, width: 100, height: 30), title: "Message", imageName: nil, bgImageName: nil, target: self, action: #selector(messageAction))
        view.addSubview(FBMessageBtn)
        let buttonWidth:CGFloat = 50
        let fbme = FBSDKMessengerShareButton.circularButton(with: .blue, width: buttonWidth)
        fbme?.addTarget(self, action: #selector(messageAction), for: .touchUpInside)
        view.addSubview(fbme!)

        let friendsLabel = ZKTools.createLabel(CGRect(x: 20, y: 210, width: 300, height: 30), title: "使用App的好友共:", textAlignment: .center, font: nil, textColor: nil)
        view.addSubview(friendsLabel)
        let imageView = ZKTools.createImageView(CGRect(x: 20, y: 250, w: 50, h: 50), imageName: nil, imageUrl: nil)
        view.addSubview(imageView)
        
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
                //let graphPath = "/me?fields=about,email,friends,picture,birthday,name"
                let graphPath = "/me/friends?fields=picture,name"
                let request = FBSDKGraphRequest(graphPath: graphPath, parameters: nil, httpMethod: "GET")
                let _ = request?.start(completionHandler: {
                    //[weak self]
                    (connection, result, error) in
                    print(connection as Any)
                    print(result as Any)
                    if let resul = result{
                        if (resul as AnyObject).isKind(of:NSDictionary.self){
//                            let model = FBPersonInforModel.parseWithDict(dict: resul as! Dictionary<String,Any>)
//                            if (model.friends?.data?.count)!>0{
//                                friendsLabel.text = "使用App的共同好友:" + "\(String(describing: model.friends?.data?.count))" + "人"
//                                if let data = model.friends?.data {
//                                    if let name = data[0].name{
//                                        print(name)
//                                    }
//                                }
//                                
//                            }
//                            if let picUrl = model.picture?.data?.url{
//                                imageView.kf.setImage(with: URL(string: picUrl))
//                            }
                            let model = FBFriendsModel.parseWithDict(dict: resul as! Dictionary<String,Any>)
                            if (model.data?.count)!>0{
                                self.model = model
                                self.tableView.reloadData()
                                friendsLabel.text = "使用App的共同好友:" + "\(String(describing: model.data?.count))" + "人"
                                if let data = model.data {
                                    if let name = data[0].name{
                                        print(name)
                                    }
                                    if let picUrl = data[0].picture?.data?.url{
                                        imageView.kf.setImage(with: URL(string: picUrl))
                                    }
                                }
                            }

                        }
                    }
                    
                    if error != nil{
                        print(error as Any)
                    }
                })
                
                
            }
            
            
        }
        
        
        
    }
    @objc private func messageAction(){
//        let image = UIImage(named: "swift.png")
//        FBSDKMessengerSharer.share(image, with: nil)
//        let avc = UIActivityViewController(activityItems: ["abc",URL(string: "https://www.uilucky.com")!], applicationActivities: nil)
//        avc.excludedActivityTypes=[UIActivityType.airDrop];
//        presentVC(avc)
        let composer = TWTRComposer()
        composer.setText("asdfasdf")
        //composer.setURL(URL(string: "https://www.uilucky.com"))
        composer.setURL(URL(string: "http://eshare.vod.otvcloud.com/otv/yfy/D/11/03/00000409445/409445_2300k_1920x1080.mp4"))
        composer.show(from: self) { (result) in
            if(result == .done){
                print("成功")
            }else{
                print("取消")
            }
        }
        
    }

    @objc private func fbAction(){
        let content = FBSDKShareLinkContent()
        //content.contentURL = URL(string: "https://www.uilucky.com")
        content.contentURL = URL(string: "http://eshare.vod.otvcloud.com/otv/yfy/D/11/03/00000409445/409445_2300k_1920x1080.mp4")
//        let dialog = FBSDKShareDialog()
//        dialog.fromViewController = self;
//        dialog.shareContent = content
//        dialog.mode = FBSDKShareDialogMode.shareSheet
//        dialog.show()
        FBSDKShareDialog.show(from: self, with: content, delegate: nil)
        
        
    
    
    }
    
    
    private func createTableView(){
        tableView = UITableView(frame: CGRect(x: 0, y: kScreenHeight/2, w: kScreenWidth, h: 300), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
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
extension ShareViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model == nil{
            return 0
        }
        return (model.data?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellid"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = model.data?[indexPath.row].name
        cell?.imageView?.kf.setImage(with: URL(string: (model.data?[indexPath.row].picture?.data?.url)!))
        return cell!
    }
}
