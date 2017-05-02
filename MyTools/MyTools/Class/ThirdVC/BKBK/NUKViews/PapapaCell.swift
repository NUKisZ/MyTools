//
//  PapapaCell.swift
//  NUK
//
//  Created by NUK on 16/8/13.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit
class PapapaCell: UITableViewCell {
    var papapaImageView:UIImageView?
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configModel(_ model:PapapaModel){
        let t =  CGFloat(model.width!) / kScreenWidth
        self.papapaImageView = ZKTools.createImageView(CGRect(x: 0, y: 0, width: kScreenWidth, height: CGFloat(model.height!) / t), imageName: nil, imageUrl: nil)
        DispatchQueue.main.async {
            [weak self]in
            self!.addSubview(self!.papapaImageView!)
        }
        
        let urlString = URL(string: model.url!)
        self.papapaImageView?.kf.setImage(with: urlString)
        
        
        let cache = KingfisherManager.shared.cache
        cache.clearMemoryCache()
        
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
