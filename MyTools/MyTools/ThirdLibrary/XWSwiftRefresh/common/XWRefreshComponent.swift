//
//  XWRefreshComponent.swift
//  XWRefresh
//
//  Created by Xiong Wei on 15/9/8.
//  Copyright © 2015年 Xiong Wei. All rights reserved.
//  简书：猫爪


import UIKit


/** 刷新状态 */
public enum XWRefreshState:Int{
    /**普通闲置状态 */
    case idle = 1
    /** 松开可以进行刷新状态 */
    case pulling = 2
    /**正在刷新中的状态 */
    case refreshing = 3
    /** 即将刷新的状态 */
    case willRefresh = 4
    /**没有数据需要加载 */
    case noMoreData = 5
}

/** 闭包的类型 ()->() */
public typealias XWRefreshComponentRefreshingClosure = ()->()

/** 抽象类，不直接使用，用于继承后，重写*/
open class XWRefreshComponent: UIView {

    //MARK: 公共接口
    //MARK 给外界访问的
    
    //1.字体颜色
    open var textColor:UIColor?
    
    //2.字体大小
    open var font:UIFont?
    
    //3.刷新的target
    fileprivate weak var refreshingTarget:AnyObject!
    
    //4.执行的方法
    fileprivate var refreshingAction:Selector = Selector("")
    
    //5.真正刷新 回调
    var refreshingClosure:XWRefreshComponentRefreshingClosure = {}
    
    /** 拉拽的百分比 */
    open var pullingPercent:CGFloat = 1 {
        didSet{
            
            if self.state == XWRefreshState.refreshing { return }
            if self.automaticallyChangeAlpha == true {
                self.alpha = pullingPercent
            }
        }
    }
    
    /** 根据拖拽比例自动切换透明度 */
    open var automaticallyChangeAlpha:Bool = false {
        didSet{
            if self.state == XWRefreshState.refreshing { return }
            if automaticallyChangeAlpha == true {
                self.alpha = self.pullingPercent
            }else {
                self.alpha = 1
            }
        }
    }
    
    /**8.刷新状态，交给子类重写 */
    var state = XWRefreshState.idle
    
    /** 是否在刷新 */
    open var isRefreshing:Bool{
        get {
            return self.state == .refreshing || self.state == .willRefresh;
        }
    }
    
       
    //MARK 方法
    //提供方便，有提示
    func addCallBack(_ block:@escaping XWRefreshComponentRefreshingClosure){
        self.refreshingClosure = block
    }
    
    
    //MARK: 遍历构造方法
    
    /** 闭包回调 */
    public convenience
    init(ComponentRefreshingClosure:@escaping XWRefreshComponentRefreshingClosure){
        self.init()
        self.refreshingClosure = ComponentRefreshingClosure
        
    }
    
    /**target action 回调 [推荐]*/
    public convenience
    init(target:AnyObject, action:Selector){
        self.init()
        self.setRefreshingTarget(target, action: action)
    }

    
    /* 1. 设置 回调方法 */
    func setRefreshingTarget(_ target:AnyObject, action:Selector){
        self.refreshingTarget = target
        self.refreshingAction = action
        
    }
    
    //MARK 公共接口  提供给子类重写
    
    
    /** 开始刷新,进入刷新状态 */
    open func beginRefreshing(){
        
        UIView.animate(withDuration: XWRefreshSlowAnimationDuration, animations: { () -> Void in
            self.alpha = 1.0
        }) 
        
        self.pullingPercent = 1.0
        
        //在刷新
        if let _ =  self.window {
            self.state = .refreshing
        }else{
            self.state = XWRefreshState.willRefresh
            // 刷新(预防从另一个控制器回到这个控制器的情况，回来要重新刷新一下)
            self.setNeedsDisplay()
        }

    }
    /** 结束刷新 */
    open func endRefreshing(){
        self.state = .idle
    
    }
    

    /**
     5. 初始化 
    */
    func prepare(){
        // 基本属性 只适应 高度
        self.autoresizingMask = UIViewAutoresizing.flexibleWidth
        self.backgroundColor = UIColor.clear
    }
    
    /** 6. 摆放子控件 */
    func placeSubvies(){}
    
    /** 7. 当scrollView的contentOffset发生改变的时候调用 */
    func scrollViewContentOffsetDidChange(_ change:Dictionary<String, AnyObject>?){}
    
    /** 8. 当scrollView的contentSize发生改变的时候调用 */
    func scrollViewContentSizeDidChange(_ change:Dictionary<String, AnyObject>?){}
    
    /** 9. 当scrollView的拖拽状态发生改变的时候调用 */
    func scrollViewPanStateDidChange(_ change:Dictionary<String, AnyObject>?){}
    
    /** 促发回调 */
    func executeRefreshingCallback(){
        
        DispatchQueue.main.async { () -> Void in
            
            self.refreshingClosure()
            
            //执行方法
            if let realTager = self.refreshingTarget {
                if realTager.responds(to: self.refreshingAction) == true {
                    
                    
                    let timer = Timer.scheduledTimer(timeInterval: 0, target: self.refreshingTarget, selector: self.refreshingAction, userInfo: nil, repeats: false)
                    RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
                }
            }
        
        }
        
        
    }
    
    

    //MARK 私有的
    
    /** 记录scrollView刚开始的inset */
    var scrollViewOriginalInset:UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    /** 父控件 */
    weak var scrollView:UIScrollView!
    
    fileprivate var pan:UIPanGestureRecognizer!
    
    //从写初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.prepare()
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //重写父类方法 这个view 会添加到 ScrollView 上去
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        //1.旧的父控件 移除监听
        self.removeObservers()
        
        //2.添加监听
        if let tmpNewSuperview = newSuperview  {
            
            //2.1设置宽度
            self.xw_width = tmpNewSuperview.xw_width
            
            //2.2 设置位置
            self.xw_x = 0
    
            
            //2.3记录UIScrollView
            self.scrollView = tmpNewSuperview as! UIScrollView
            
            //2.4 设置用于支持 垂直下拉有弹簧的效果
            self.scrollView.alwaysBounceVertical = true;
            
            //2.5 记录UIScrollView最开始的contentInset
            self.scrollViewOriginalInset = self.scrollView.contentInset;
            
            //2.6 添加监听
            self.addObservers()

        }
    }
    
    //MARK:  添加监听
    fileprivate func addObservers(){
        
        let options:NSKeyValueObservingOptions = NSKeyValueObservingOptions.new
        
         self.scrollView.addObserver(self , forKeyPath: XWRefreshKeyPathContentSize, options: options, context: nil)
    
        self.scrollView.addObserver(self , forKeyPath: XWRefreshKeyPathContentOffset, options: options, context: nil)
        
        self.pan = self.scrollView.panGestureRecognizer
        
        self.pan.addObserver(self , forKeyPath: XWRefreshKeyPathPanKeyPathState, options: options, context: nil)
        
    }
    
    fileprivate func removeObservers(){
        
        if let realSuperview = self.superview {
            realSuperview.removeObserver(self, forKeyPath: XWRefreshKeyPathContentOffset)
                //TODO: 写到这里，不知道什么原因，但是可以肯定没有销毁
            realSuperview.removeObserver(self, forKeyPath: XWRefreshKeyPathContentSize)            
        }
        if let realPan = self.pan {
            realPan.removeObserver(self, forKeyPath: XWRefreshKeyPathPanKeyPathState)
        }
        self.pan = nil
    }
    
    
    //MARK: drawRect
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if self.state == XWRefreshState.willRefresh {
            // 预防view还没显示出来就调用了beginRefreshing
            self.state = .refreshing
        }
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.placeSubvies()
    }
    
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //需要这种情况就直接返回
        if !self.isUserInteractionEnabled { return }
        
        if keyPath == XWRefreshKeyPathContentSize {
            let dic = change! as NSDictionary
            let dict = dic as! Dictionary<String, AnyObject>
            self.scrollViewContentSizeDidChange(dict)
        }

        if self.isHidden {return}
        
        if keyPath == XWRefreshKeyPathContentOffset{
            let dic = change! as NSDictionary
            let dict = dic as! Dictionary<String, AnyObject>
            self.scrollViewContentOffsetDidChange(dict)
        }else if keyPath == XWRefreshKeyPathPanKeyPathState{
            
            let dic = change! as NSDictionary
            let dict = dic as! Dictionary<String, AnyObject>
            self.scrollViewPanStateDidChange(dict)
        }
    }
    
}


extension UILabel {
    
    func Lable() -> UILabel {
        
        let myLable = UILabel()
        myLable.font = XWRefreshLabelFont;
        myLable.textColor = XWRefreshLabelTextColor;
        myLable.autoresizingMask = UIViewAutoresizing.flexibleWidth;
        myLable.textAlignment = NSTextAlignment.center;
        myLable.backgroundColor = UIColor.clear;
        return myLable
    }
}



