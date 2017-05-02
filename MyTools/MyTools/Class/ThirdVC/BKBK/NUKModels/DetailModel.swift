//
//  DetailModel.swift
//  NUK
//
//  Created by NUK on 16/8/13.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class DetailModel: NSObject {
    var updated_at:String?
    var id:NSNumber?
    var name:String?
    var author:String?
    var finished:String?
    var total_page:NSNumber?
    var img_directory:String?
    var views_count:NSNumber?
    var myDescription:String?
    var display_name:String?
    var cover_image:String?
    var rank:NSNumber?
    var comment_count:NSNumber?
    var user_id:NSNumber?
    var ep_count:NSNumber?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

    func setDescription(_ description:String?){
        self.myDescription = description
    }
}
