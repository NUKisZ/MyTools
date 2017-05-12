//
//  ButtonAddBadge.swift
//  MengWuShe
//
//  Created by zhangk on 16/10/26.
//  Copyright © 2016年 zhangk. All rights reserved.
//

import UIKit
class ButtonBadge: UIView {
    //有提示的Button
    var badge:Int = 0{
        didSet{
            if badge > 0 {
                for subView in subviews{
                    if subView.tag == 100{
                        subView.removeFromSuperview()
                    }
                }
                let label = ZKTools.createLabel(CGRect(x: frame.size.width-15, y: 0, width:15, height: 15), title: "\(badge)", textAlignment: NSTextAlignment.center, font: UIFont.systemFont(ofSize: 8), textColor: UIColor.red)
                label.layer.cornerRadius = label.frame.size.width/2
                label.layer.masksToBounds = true
                label.backgroundColor = UIColor.red
                label.textColor = UIColor.white
                label.tag = 100
                addSubview(label)
            }else{
                for subView in subviews{
                    if subView.tag == 100{
                        subView.removeFromSuperview()
                    }
                }
            }
        }
    }
    init(frame: CGRect,title:String?,imageName:String?,bgImageName:String?,target:AnyObject?,action:Selector?) {
        super.init(frame: frame)
        
        let btn = ZKTools.createButton(CGRect(x: frame.origin.x, y: frame.origin.y+5, width: frame.size.width-5, height: frame.size.height-5), title: title, imageName: imageName, bgImageName: bgImageName, target: target, action: action)
        
        addSubview(btn)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class OtherLoginView:UIControl{
    
    

    //其他登录方式的按钮
    init(frame: CGRect,imageName:String,title:String) {
        super.init(frame: frame)
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*0.8))
        let path = Bundle.main.path(forResource: imageName, ofType: "png")
        
        let image1 = UIImage(contentsOfFile: path!)
        
        imageView.image = image1
        addSubview(imageView)
        let label = ZKTools.createLabel(CGRect(x: 0, y: frame.size.height*0.8, width: frame.size.width, height: frame.size.height*0.2), title: title, textAlignment: NSTextAlignment.center, font: UIFont.systemFont(ofSize: 10), textColor: UIColor.black)
        addSubview(label)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
