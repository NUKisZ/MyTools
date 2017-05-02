//
//  DetailButton.swift
//  NUK
//
//  Created by NUK on 16/8/13.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class DetailButton: UIControl {

    var ep_count:NSNumber!{
        didSet{
            self.label?.text = "第\((self.ep_count)!)章"
        }
    }
    fileprivate var label:UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellow
        self.label = ZKTools.createLabel(CGRect(x: 0, y: 0, width: frame.width, height: frame.height), title: nil, textAlignment: nil, font: nil, textColor: nil)
        self.label?.textAlignment = .center
        self.addSubview(self.label!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
