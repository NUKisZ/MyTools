//
//  UIScrollViewExtension-XW.swift
//  XWRefresh
//
//  Created by Xiong Wei on 15/9/9.
//  Copyright © 2015年 Xiong Wei. All rights reserved.
//  简书：猫爪


import UIKit


private var XWRefreshHeaderKey:Void?
private var XWRefreshFooterKey:Void?

private var XWRefreshReloadDataClosureKey:Void?


typealias xwClosureParamCountType = (Int)->Void

open class xwReloadDataClosureInClass {
    var reloadDataClosure:xwClosureParamCountType = { (Int)->Void in }
}
//用于加强一个引用
//var xwRetainClosureClass = xwReloadDataClosureInClass()


public extension UIScrollView {
    
    
    /** ===========================================================================================
                                        1.2 version 
    ===============================================================================================*/

    
    //MARK: 1.2 version

    /** reloadDataClosure */
    var reloadDataClosureClass:xwReloadDataClosureInClass {
        set{
            
            self.willChangeValue(forKey: "reloadDataClosure")
            //因为闭包不属于class 所以不合适 AnyObject
            objc_setAssociatedObject(self, &XWRefreshReloadDataClosureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            self.didChangeValue(forKey: "reloadDataClosure")
        }
        get{
            if let realClosure = objc_getAssociatedObject(self, &XWRefreshReloadDataClosureKey) {
                return realClosure as! xwReloadDataClosureInClass
            }
            return xwReloadDataClosureInClass()
        }
        
    }
    
	/** 下拉刷新的控件 */
	var headerView:XWRefreshHeader?{

		set{
			if self.headerView == newValue { return }
            
			self.headerView?.removeFromSuperview()
			objc_setAssociatedObject(self,&XWRefreshHeaderKey, newValue , objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)

			if let newHeaderView = newValue {
				self.addSubview(newHeaderView)
			}
		}
		get{
			return objc_getAssociatedObject(self, &XWRefreshHeaderKey) as? XWRefreshHeader
		}
	}



	/** 上拉刷新的控件 */
	var footerView:XWRefreshFooter?{

		set{
			if self.footerView == newValue { return }
			self.footerView?.removeFromSuperview()
			objc_setAssociatedObject(self,&XWRefreshFooterKey, newValue , objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)

			if let newFooterView = newValue {
				self.addSubview(newFooterView)
			}
		}
		get{
			return objc_getAssociatedObject(self, &XWRefreshFooterKey) as? XWRefreshFooter
		}
	}
    
    var totalDataCount:Int{
        
        get{
            var totalCount:Int = 0
            if self.isKind(of: UITableView.self){
                let tableView = self as! UITableView
                let num  = tableView.numberOfSections + 1
                for section in 0..<num {
                    //totalCount += tableView.numberOfRows(inSection: section)
                }
                
            }else if self.isKind(of: UICollectionView.self) {
                let collectionView = self as! UICollectionView
                let num = collectionView.numberOfSections + 1
                for section in 0  ..< num {
                    totalCount += collectionView.numberOfItems(inSection: section)
                }
            }
            return totalCount
            
        }
    }
    
    func executeReloadDataClosure(){
        self.reloadDataClosureClass.reloadDataClosure(self.totalDataCount)
    }
    
    
    
    /** ===========================================================================================
                                            1.0 version deprecated
    ===============================================================================================*/

    //MARK: 1.0 version
    
    @available(*, deprecated: 1.0, message: "Use -self.tableView.headerView = XWRefreshNormalHeader(target: self, action: Selector ) instead.")
    /**
    添加上拉刷新回调
    - parameter callBack: 闭包代码块,当心循环引用 使用 [weak self]
    */
    func addHeaderWithCallback(_ callBack:@escaping (Void)->()){
        self.headerView = XWRefreshNormalHeader(ComponentRefreshingClosure: callBack)
    }
    
    @available(*, deprecated: 1.0, message: "Use -self.tableView.footerView = XWRefreshAutoNormalFooter(target: self, action: Selector) instead.")
    /** 添加下拉刷新回调,当心循环引用 使用 [weak self] */
    func addFooterWithCallback(_ callBack:@escaping (Void)->()){
        
        self.footerView = XWRefreshAutoNormalFooter(ComponentRefreshingClosure: callBack)
    }
    
    @available(*, deprecated: 1.0, message: "Use -self.tableView.headerView?.beginRefreshing() instead.")
    /** 开始headerView刷新 */
    func beginHeaderRefreshing(){
        if let real = self.headerView {
            real.beginRefreshing()
        }
    }
    
    @available(*, deprecated: 1.0, message: "Use -self.tableView.headerView?.endRefreshing() instead.")
    /** 停止headerView刷新 */
    func endHeaderRefreshing(){
        if let real = self.headerView {
            real.endRefreshing()
        }
    }
    
    @available(*, deprecated: 1.0, message: "Use -self.tableView.footerView?.beginRefreshing()  instead.")
    /** 开始footerView刷新 */
    func beginFooterRefreshing(){
        if let real = self.footerView {
            real.beginRefreshing()
        }
    }
    
    @available(*, deprecated: 1.0, message: "Use -self.tableView.footerView?.endRefreshing() instead.")
    /** 停止footerView刷新 */
    func endFooterRefreshing(){
        if let real = self.footerView {
            real.endRefreshing()
        }
    }

}


extension UITableView {
    
    open override class func initialize(){
        if self != UITableView.self { return }
        
        
        
        
        
//        var once :UITableView{
//            struct Static{
//                static let instance:UITableView=UITableView()
//                self.exchangeInstanceMethod1(Selector("reloadData"), method2: Selector("xwReloadData"))
//            }
//            return Static.instance
//        }
        
        
        
        struct once{
            static var onceTaken:Int = 0
        }
        
//        class sharedFoo {
//            self.exchangeInstanceMethod1(Selector("reloadData"), method2: Selector("xwReloadData"))
//            //return sharedInstance
//        }
        
        self.exchangeInstanceMethod1(#selector(UICollectionView.reloadData), method2: #selector(UITableView.xwReloadData))
        
//        dispatch_once(&once.onceTaken) { () -> Void in
//            
//            self.exchangeInstanceMethod1(Selector("reloadData"), method2: Selector("xwReloadData"))
//        }
        
    }
    
    func xwReloadData(){
        //正因为交换了方法，所以这里其实是执行的系统自己的 reloadData 方法
        self.xwReloadData()
        
        self.executeReloadDataClosure()
        
    }
}
























