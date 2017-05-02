//
//  StarView.swift
//  1606LimitFree
//
//  Created by NUK on 16/8/1.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class StarView: UIView {

    //背影图片
    
    var bgImageView:UIImageView?
    //前景图片
    
    var fgImageView:UIImageView?
    
    //代码初始化的时候调用
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createImageView()
        
        
    }
    //xib初始化的时候调用
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //创建图片视图
        self.createImageView()
    }
    
    
    //StarsBackground
    //StarsForeground
    
    func createImageView(){
        //背景图片
        self.bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 65, height: 46))
        self.bgImageView?.image = UIImage(named: "StarsBackground")
            
            
            //ZKTools.createImageView(CGRectMake(0, 0, 130, 46), imageName: "StarsBackground")
        self.addSubview(self.bgImageView!)
        //前景图片
        self.fgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 65, height: 46))
        self.fgImageView?.image = UIImage(named: "StarsForeground")
            //ZKTools.createImageView(CGRectMake(0, 0, 130, 46), imageName: "StarsForeground")
        self.addSubview(self.fgImageView!)
        //停靠模式
        self.fgImageView?.contentMode = .left
        self.fgImageView?.clipsToBounds = true
    }
    //设置星级
    func setRating(_ rating:CGFloat){
        self.fgImageView?.frame.size.width = 65 * rating / 5.0
    }
    
    
    
}
