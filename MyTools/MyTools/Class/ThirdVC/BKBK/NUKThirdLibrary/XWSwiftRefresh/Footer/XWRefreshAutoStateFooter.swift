//
//  XWRefreshAutoStateFooter.swift
//  XWSwiftRefresh
//
//  Created by Xiong Wei on 15/10/6.
//  Copyright © 2015年 Xiong Wei. All rights reserved.
//  简书：猫爪


import UIKit

/** footerView 只有状态文字 */
open class XWRefreshAutoStateFooter: XWRefreshAutoFooter {
    
    //MARK: 外部

    /** 显示刷新状态的label */
    lazy var stateLabel:UILabel = {
       [unowned self] in
        let lable = UILabel().Lable()
        self.addSubview(lable)
        return lable
    }()
    
    /** 隐藏刷新状态的文字 */
    open var refreshingTitleHidden:Bool = false
    
    /** 设置状态的显示文字 */
    open func setTitle(_ title:String, state:XWRefreshState){
        self.stateLabel.text = self.stateTitles[self.state];
    }

    
    //MARK: 私有的
    /** 每个状态对应的文字 */
    fileprivate var stateTitles:Dictionary<XWRefreshState, String> = [
        XWRefreshState.idle : XWRefreshFooterStateIdleText,
        XWRefreshState.refreshing : XWRefreshFooterStateRefreshingText,
        XWRefreshState.noMoreData : XWRefreshFooterStateNoMoreDataText
    ]
    
    override func prepare() {
        super.prepare()
        
        self.stateLabel.isUserInteractionEnabled = true
        self.stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(XWRefreshAutoStateFooter.stateLabelClick)))
        self.stateLabel.text = self.stateTitles[state]

    }
    
    func stateLabelClick(){
        if self.state == XWRefreshState.idle {
            self.beginRefreshing()
        }
    }
    
    override func placeSubvies() {
        super.placeSubvies()
        self.stateLabel.frame = self.bounds
    }
    
    
    override var state:XWRefreshState {
        didSet{
            if oldValue == state { return }
                
            if self.refreshingTitleHidden && state == XWRefreshState.refreshing {
                self.stateLabel.text = nil
            }else {
                self.stateLabel.text = self.stateTitles[state]
            }
        }
    }
}
