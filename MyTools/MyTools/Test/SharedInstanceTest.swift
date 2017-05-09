//
//  SharedInstanceTest.swift
//  MyTools
//
//  Created by gongrong on 2017/5/8.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class SharedInstanceTest: NSObject {
    var i:Int?
    private override init() {
        super.init()
    }
    static let sharedInstance = SharedInstanceTest()
    class func message(){
        print("单例测试")
    }
}
