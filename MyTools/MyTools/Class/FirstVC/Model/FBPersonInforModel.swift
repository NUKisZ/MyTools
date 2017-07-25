//
//  FBPersonInforModel.swift
//  MyTools
//
//  Created by gongrong on 2017/7/25.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class FBPersonInforModel: NSObject {

    var id:String?
    var name:String?
    var email:String?
    var first_name:String?
    var picture:FBPictureModel?
    var friends:FBFriendsModel?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    class func parseWithDict(dict:Dictionary<String,Any>)->FBPersonInforModel{
        let model = FBPersonInforModel()
        model.setValuesForKeys(dict)
        
        if let friends = dict["friends"] {
            let friendsModel = FBFriendsModel.parseWithDict(dict: friends as! Dictionary<String,Any>)
            model.friends = friendsModel
        }
        if let picture = dict["picture"]{
            let pictureModel = FBPictureModel.parseWithDict(dict: picture as! Dictionary<String,Any>)
            model.picture = pictureModel
        }
        
        return model
    }
    
    
}
