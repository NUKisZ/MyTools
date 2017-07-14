//
//  GalleryCollectionViewCell.swift
//  MyTools
//
//  Created by gongrong on 2017/7/14.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    var imageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        contentView.addSubview(imageView)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
