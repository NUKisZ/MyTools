//
//  XWRefreshAutoNormalFooter.swift
//  XWSwiftRefresh
//
//  Created by Xiong Wei on 15/10/6.
//  Copyright © 2015年 Xiong Wei. All rights reserved.
//  简书：猫爪


import UIKit

/** footerView 带有菊花和状态文字的 */
open class XWRefreshAutoNormalFooter: XWRefreshAutoStateFooter {
    
    //MARK: 外部访问
    /** 菊花样式 */
    open var activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray {
        
        didSet{
            self.activityView.activityIndicatorViewStyle = activityIndicatorViewStyle
            self.setNeedsLayout()
        }
    }
    
    
    //MARK: 私有
    
    //菊花
    lazy var activityView:UIActivityIndicatorView = {
        
        [unowned self] in
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: self.activityIndicatorViewStyle)
        activityView.hidesWhenStopped = true
        self.addSubview(activityView)
        
        return activityView
        }()
    
    
    //MARK: 重写
    override func placeSubvies() {
        super.placeSubvies()
        //菊花
        var activityViewCenterX = self.xw_width * 0.5
        if !self.refreshingTitleHidden { activityViewCenterX -=  XWRefreshFooterActivityViewDeviation }
        let activityViewCenterY = self.xw_height * 0.5
        self.activityView.center = CGPoint(x: activityViewCenterX, y: activityViewCenterY)
    }
    
    override var state:XWRefreshState{
        didSet{
            if oldValue == state { return }
                
                
            if  state == XWRefreshState.noMoreData || state == XWRefreshState.idle {
                
                self.activityView.stopAnimating()
                
            }else if state == XWRefreshState.refreshing  {
                
                self.activityView.startAnimating()
            }
        }
    }

    

}
