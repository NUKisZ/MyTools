//
//  MOBPlatformViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/7/27.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class MOBPlatformViewController: BaseViewController {

    var mobTableView:UITableView!
    var platformType:SSDKPlatformType!
    var shareIconArray=Array<Any>()
    var shareTypeArray=Array<Any>()
    var selectorNameArray=Array<Any>()
    var authTypeArray=Array<Any>()
    var authSelectorNameArray=Array<Any>()
    var otherTypeArray=Array<Any>()
    var otherSelectorNameArray=Array<Any>()
    var hasAuth:Bool!
    fileprivate var isShare:Bool=false
    fileprivate var selectIndexPath:IndexPath!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-64-49), style: .grouped, separatorStyle: .none)
        automaticallyAdjustsScrollViewInsets = false
    }

    func createTableView(frame:CGRect,style:UITableViewStyle,separatorStyle:UITableViewCellSeparatorStyle){
        mobTableView = UITableView(frame: frame, style: style)
        mobTableView.delegate = self
        mobTableView.dataSource = self
        mobTableView.separatorStyle = separatorStyle
        view.addSubview(mobTableView)
        
    }
    func shareWithParameters(parameters:NSMutableDictionary){
        if isShare{
            return
        }
        isShare = true
        if parameters.count == 0 {
            let alertView = UIAlertView(title: "", message: "请先设置分享参数", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "确定")
            alertView.show()
            return
        }
        ShareSDK.share(platformType, parameters: parameters) { (state, userData, contentEntity, error) in
            if state == SSDKResponseState.beginUPLoad{
                return
            }
            var titel = ""
            var typeStr = ""
            var typeColor = UIColor.gray
            switch state{
            case .success:
                self.isShare = false
                titel = "分享成功"
                typeStr = "成功"
                typeColor = UIColor.blue
            case .fail:
                self.isShare = false
                print("error:\(String(describing: error))")
                titel = "分享失败"
                typeStr = "\(String(describing: error))"
                typeColor = UIColor.red
            case .cancel:
                self.isShare = false
                titel = "分享取消"
                typeStr = "取消"
            default:
                break
            }
            
            let alertView = UIAlertView(title: titel, message: typeStr, delegate: nil, cancelButtonTitle: "确定", otherButtonTitles: "其他")
            alertView.show()
        }
        
    }
    func authAct(){
        ShareSDK.authorize(platformType, settings: nil) { (state, user, error) in
            var titel = ""
            switch state{
                case .success:
                    titel = "授权成功"
                    print(user?.rawData)
                    let alertView = UIAlertView(title: titel, message: "", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定")
                    alertView.show()
            case .fail:
                titel = "授权失败"
                print("error:\(error)")
                let alertView = UIAlertView(title: titel, message: "", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定")
                alertView.show()
            case .cancel:
                titel = "取消授权"
                let alertView = UIAlertView(title: titel, message: "", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定")
                alertView.show()
            default:
                break
                
            }
        }
    }
    func isInstallAPP(){
        var titel = ""
        if ShareSDK.isClientInstalled(platformType){
            titel = "已安装"
        }else{
            titel = "未安装"
        }
        let alertView = UIAlertView(title: titel, message: "", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定")
        alertView.show()
    }

    fileprivate func funcWithSelectorName(selectorName:String){
        let sel = NSSelectorFromString(selectorName)
        if responds(to: sel){
            perform(sel)
        }
    }

}
extension MOBPlatformViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return authTypeArray.count
        case 1:
            return shareTypeArray.count
        case 2:
            return otherTypeArray.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "reuseCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if(cell == nil){
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
        }
        switch indexPath.section {
        case 0:
            if(ShareSDK.hasAuthorized(platformType)){
                cell?.detailTextLabel?.text = "已授权"
                cell?.detailTextLabel?.textColor = UIColor.blue
            }else{
                cell?.detailTextLabel?.text = "未授权"
                cell?.detailTextLabel?.textColor = UIColor.gray
            }
            cell?.textLabel?.text = authTypeArray[indexPath.row] as? String
        case 1:
            cell?.textLabel?.text = shareTypeArray[indexPath.row] as? String
            cell?.detailTextLabel?.text = ""
            let imageName = shareIconArray[indexPath.row] as! String
            cell?.imageView?.image = UIImage(named: imageName)
        case 2:
            cell?.textLabel?.text = otherTypeArray[indexPath.row] as? String
            cell?.detailTextLabel?.text = ""
        default:
            cell?.textLabel?.text = ""
            cell?.detailTextLabel?.text = ""
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            if indexPath.row<authSelectorNameArray.count{
                if ShareSDK.hasAuthorized(platformType){
                    let alertView = UIAlertView(title: "是否取消授权", message: "", delegate: nil, cancelButtonTitle: "暂不", otherButtonTitles: "确认")
                    alertView.tag = 1000
                    alertView.show()
                }else{
                    let selectorName = authSelectorNameArray[indexPath.row] as! String
                    funcWithSelectorName(selectorName: selectorName)
                }
            }
        case 1:
            if indexPath.row < selectorNameArray.count{
                selectIndexPath = indexPath
                let selectorName = selectorNameArray[indexPath.row] as! String
                funcWithSelectorName(selectorName: selectorName)
            }
        case 2:
            if(indexPath.row<otherSelectorNameArray.count){
                let selectorName = otherSelectorNameArray[indexPath.row] as! String
                funcWithSelectorName(selectorName: selectorName)
            }
        default:
            break
        }
    }
}
