//
//  MBToast.swift
//  MyTools
//
//  Created by gongrong on 2017/7/21.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class MBToast: NSObject {

    
    class func showToast(toast:String){
        let view = UIApplication.shared.windows.last
        MBToast.showToast(showView: view!, toast: toast)
        
    }
    class func showToast(showView:UIView,toast:String) {
        let hud = MBProgressHUD .showAdded(to: showView, animated: true)
        hud.bezelView.backgroundColor = UIColor.black
        hud.contentColor = UIColor.white
        hud.mode = .text
        hud.label.text = toast
        hud.removeFromSuperViewOnHide = true
        hud.isUserInteractionEnabled = false
        hud.hide(animated: true, afterDelay: 2)
    }
    

}
