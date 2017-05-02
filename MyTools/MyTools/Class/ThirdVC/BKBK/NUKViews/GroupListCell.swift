//
//  GroupListCell.swift
//  NUK
//
//  Created by NUK on 16/8/13.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class GroupListCell: UITableViewCell {
    
    
    @IBOutlet weak var appImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var starView: StarView!
    
    func config(_ model:GroupListModel){
        let urlString = URL(string: model.cover_image!)
        self.appImageView.kf.setImage(with: urlString)
        self.nameLabel.text = model.name!
        if model.rank != nil {
            let rank = model.rank!
            self.starView.setRating(CGFloat(rank))

        }
        
        
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
