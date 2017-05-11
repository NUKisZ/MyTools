//
//  FirstViewControllerCell.swift
//  MyTools
//
//  Created by gongrong on 2017/5/10.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class FirstViewControllerCell: UITableViewCell {
    public var button:UIButton?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        button = UIButton(type: .custom)
        button?.frame = CGRect(x: 10, y: 5, w: 50, h: 20)
        contentView.addSubview(button!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
