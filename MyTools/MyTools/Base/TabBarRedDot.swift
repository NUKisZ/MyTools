//
//  TabBarRedDot.swift
//  MyTools
//
//  Created by 张坤 on 2017/8/17.
//  Copyright © 2017年 张坤. All rights reserved.
//
private let TabbarItemNums:CGFloat = 3.0
private let sizeWH:CGFloat = 6
extension UITabBar{
    
    func showBadgeOnItemIndex(index:Int) {
        removeBadgeOnItemIndex(index: index)
        let badgeView = UIView()
        badgeView.tag = 888 + index
        let flag:CGFloat = 2
        badgeView.layer.cornerRadius = sizeWH / flag
        badgeView.backgroundColor = UIColor.red
        let tabFrame = frame
        let percentX:CGFloat = ( CGFloat(index) + 0.6) / TabbarItemNums
        let x = ceil(percentX * tabFrame.size.width)
        let y = ceil(0.1 * tabFrame.size.height)
        badgeView.frame = CGRect(x: x, y: y, width: sizeWH, height: sizeWH)
        addSubview(badgeView)
        
    }
    func hideBadgeOnItemIndex(index:Int) {
        removeBadgeOnItemIndex(index: index)
    }
    private func removeBadgeOnItemIndex(index:Int){
        for subView in subviews {
            if subView.tag == index + 888{
                subView.removeFromSuperview()
            }
        }
    }
}

