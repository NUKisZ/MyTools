//
//  ActivityView.swift
//  MyTools
//
//  Created by gongrong on 2017/7/10.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class ActivityView: UIView {

    private var titleLabel:UILabel!
    public var titleString:String?{
        didSet{
            titleLabel.text = titleString
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let act = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        act.color = UIColor.red
        act.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        addSubview(act)
        act.startAnimating()
        titleLabel = UILabel(frame: CGRect(x: 0, y: frame.size.height-30, w: frame.size.width, h: 30));
        titleLabel.text = titleString
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        addSubview(titleLabel)
        backgroundColor = UIColor.init(white: 0.3, alpha: 0.8)
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
