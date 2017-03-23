//
//  ProgressHUD.swift
//  LimitFree1606
//
//  Created by gaokunpeng on 16/7/28.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit


public let kProgressImageName = "提示底.png"
public let kProgressHUDTag = 10000
public let kProgressActivityTag = 20000

class ProgressHUD: UIView {

    var textLabel: UILabel?
    
    init(center: CGPoint){
        
        super.init(frame: CGRect.zero)
        
        let bgImage = UIImage(named: kProgressImageName)

        self.bounds = CGRect(x: 0, y: 0, width: bgImage!.size.width, height: bgImage!.size.height)
        self.center = center
        
        let imageView = UIImageView(image: bgImage)
        imageView.frame = self.bounds
        self.addSubview(imageView)
        
        //self.backgroundColor = UIColor.grayColor()
        self.layer.cornerRadius = 6
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    fileprivate func show(){
        
        let uaiView = UIActivityIndicatorView(activityIndicatorStyle: .white)
        uaiView.tag = kProgressActivityTag
        uaiView.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        uaiView.backgroundColor = UIColor.clear
        uaiView.startAnimating()
        self.addSubview(uaiView)
        
        
        self.textLabel = UILabel(frame: CGRect.zero)
        self.textLabel!.backgroundColor = UIColor.clear
        self.textLabel!.textColor = UIColor.white
        self.textLabel!.text = "加载中..."
        self.textLabel!.font = UIFont.systemFont(ofSize: 15)
        self.textLabel?.sizeToFit()
        
        self.textLabel!.center = CGPoint(x: uaiView.center.x, y: uaiView.frame.origin.y+uaiView.frame.size.height+5+self.textLabel!.bounds.size.height/2)
        self.addSubview(self.textLabel!)
    
    }
    
    fileprivate func hideActivityView(){
        
        let tmpView = self.viewWithTag(kProgressActivityTag)
            
        if tmpView != nil {
            let uiaView = tmpView  as! UIActivityIndicatorView
            
            uiaView.stopAnimating()
            uiaView.removeFromSuperview()
        }
        
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }, completion: { (finished) in
            self.superview?.isUserInteractionEnabled = true
            self.removeFromSuperview()
        }) 
        
    }
    
    
    fileprivate func hideAfterSuccess(){
        
        let successImage = UIImage(named: "保存成功.png")
        
        let successImageView = UIImageView(image: successImage)
        successImageView.sizeToFit()
        successImageView.center = CGPoint(x: self.frame.size.width/2,
        y: self.frame.size.height/2)
        self.addSubview(successImageView)
        self.textLabel!.text = "加载成功"
        self.textLabel!.sizeToFit()
        
        self.hideActivityView()

    }
    
 
    fileprivate func hideAfterFail(){
        self.textLabel?.text = "加载失败"
        self.textLabel?.sizeToFit()
        
        self.hideActivityView()
    }
    

    class func showOnView(_ view: UIView){
        
        let oldHud = view.viewWithTag(kProgressHUDTag)
    
        if (oldHud != nil) {
            oldHud?.removeFromSuperview()
        }
        
        let hud = ProgressHUD(center: view.center)
        hud.tag = kProgressHUDTag
        
        hud.show()
        view.isUserInteractionEnabled = false
        view.addSubview(hud)
        
    }
    
    
   
    class func hideAfterSuccessOnView(_ view: UIView){
        
        let tmpView = view.viewWithTag(kProgressHUDTag)
            
        if tmpView != nil {
            let hud = tmpView as! ProgressHUD
            
            hud.hideAfterSuccess()
        }
        
        
        
    }
    

    class func hideAfterFailOnView(_ view: UIView){
        
        let tmpView = view.viewWithTag(kProgressHUDTag)
        
        if tmpView != nil {
            let hud = tmpView as! ProgressHUD
            
            hud.hideAfterFail()
        }
        
        
        
    }
    
   
    fileprivate class func hideOnView(_ view: UIView){
        let tmpView = view.viewWithTag(kProgressHUDTag)
        
        if tmpView != nil {
            let hud = tmpView as! ProgressHUD
            
            hud.hideActivityView()
        }

    }
    
    
    

}
