//
//  AccpetEventInterval.swift
//  MyTools
//
//  Created by gongrong on 2017/5/9.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
//import ObjectiveC
/*
public extension UIButton{
    private struct zk_associatedKeys{
        static var accpetEventInterval  = "zk_acceptEventInterval"
        static var acceptEventTime      = "zk_acceptEventTime"
    }
    var zk_accpetEventInterval: TimeInterval {
        get {
            if let accpetEventInterval = objc_getAssociatedObject(self, &zk_associatedKeys.accpetEventInterval) as? TimeInterval {
                return accpetEventInterval
            }
            
            return 1.0
        }
        
        set {
            objc_setAssociatedObject(self, &zk_associatedKeys.accpetEventInterval, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var zk_acceptEventTime: TimeInterval {
        get {
            if let acceptEventTime = objc_getAssociatedObject(self, &zk_associatedKeys.acceptEventTime) as? TimeInterval {
                return acceptEventTime
            }
            
            return 1.0
        }
        
        set {
            objc_setAssociatedObject(self, &zk_associatedKeys.acceptEventTime, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    override open class func initialize() {
        let before: Method = class_getInstanceMethod(self, #selector(UIButton.sendAction))
        let after: Method  = class_getInstanceMethod(self, #selector(UIButton.zk_sendAction(action:to:forEvent:)))
        
        method_exchangeImplementations(before, after)
    }
    
    
    func zk_sendAction(action: Selector, to target: AnyObject?, forEvent event: UIEvent?) {
        if NSDate().timeIntervalSince1970 - self.zk_acceptEventTime < self.zk_accpetEventInterval {
            return
        }
        
        if self.zk_accpetEventInterval > 0 {
            self.zk_acceptEventTime = NSDate().timeIntervalSince1970
        }
        
        self.zk_sendAction(action: action, to: target, forEvent: event)
    }
}
*/
