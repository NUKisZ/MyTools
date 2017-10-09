//
//  SIMInfoViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/6/2.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
import CoreTelephony
class SIMInfoViewController: TableViewBaseController {
    private var timer:Timer!
    var simInfo:CTTelephonyNetworkInfo!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        simInfo = CTTelephonyNetworkInfo()
        simInfo.subscriberCellularProviderDidUpdateNotifier = {
            (carrier) in
            ZKTools.alertViewCtroller(vc: self, title: nil, message: "SIM卡更换", cancelActionTitle: nil, sureActionTitle: "确定", action: nil)
        }
        automaticallyAdjustsScrollViewInsets = false
        createTableView(frame: CGRect(x: 0, y: 64, w: kScreenWidth, h: kScreenHeight-64), style: .plain, separatorStyle: .singleLine)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
        timer = nil
    }
    
    @objc private func tickDown(){
        print("执行了打印")
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
extension SIMInfoViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carrier = simInfo.subscriberCellularProvider
        let cellId = "CellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "手机号码"
            cell?.detailTextLabel?.text = kUserDefaults.object(forKey: "SBFormattedPhoneNumber") as? String
        case 5:
            cell?.textLabel?.text = "供应商"
            cell?.detailTextLabel?.text = carrier?.carrierName
        case 1:
            cell?.textLabel?.text = "所在国家编号"
            cell?.detailTextLabel?.text = carrier?.mobileCountryCode
        case 2:
            cell?.textLabel?.text = "供货应商网络"
            cell?.detailTextLabel?.text = carrier?.mobileNetworkCode
        case 3:
            cell?.textLabel?.text = "isoCountryCode"
            cell?.detailTextLabel?.text = carrier?.isoCountryCode
        case 4:
            cell?.textLabel?.text = "allowsVOIP"
            if carrier?.allowsVOIP == true {
                cell?.detailTextLabel?.text = "是"
            }else{
                cell?.detailTextLabel?.text = "否"
            }
        default:
            break
        }
        return cell!
    }
}
