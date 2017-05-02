//
//  GroupListModel.swift
//  NUK
//
//  Created by NUK on 16/8/13.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class GroupListModel: NSObject {
    var updated_at:String?
    var id:NSNumber?
    var name:String?
    var author:String?
    var finished:String?
    var total_page:NSNumber?
    var cats:NSNumber?
    var cover_image:String?
    var rank:NSNumber?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    

}
