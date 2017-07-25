//
//  FBPictureModel.swift
//  MyTools
//
//  Created by gongrong on 2017/7/25.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class FBPictureModel: NSObject {
    var data:FBPictureDataModel?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

    class func parseWithDict(dict:Dictionary<String,Any>)->FBPictureModel {
        let model = FBPictureModel()
        model.setValuesForKeys(dict)
        if let dic = dict["data"]{
            if (dic as AnyObject).isKind(of: NSDictionary.self){
                let dataModel = FBPictureDataModel.parseWithDict(dict: dic as! Dictionary<String,Any>)
                model.data = dataModel
            }
        }
        
        return model
    }
}
class FBPictureDataModel: NSObject{
    var is_silhouette:AnyObject?
    var url:String?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    class func parseWithDict(dict:Dictionary<String,Any>)->FBPictureDataModel{
        let model = FBPictureDataModel()
        model.setValuesForKeys(dict)
        return model
    }
}
