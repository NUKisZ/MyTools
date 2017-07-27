//
//  FBFriendsModel.swift
//  MyTools
//
//  Created by gongrong on 2017/7/25.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
class FBFriendsModel: NSObject {

    var data:Array<FBFriendsDataModel>?
    var paging:FBFriendsPagingModel?
    var summary:FBFriendsSummaryModel?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    class func parseWithDict(dict:Dictionary<String,Any>)->FBFriendsModel{
        let model = FBFriendsModel()
        model.setValuesForKeys(dict)
        if let dat = dict["data"]{
            if (dat as AnyObject).isKind(of:NSArray.self){
                let array = dat as! Array<Dictionary<String,Any>>
                var arrData = Array<FBFriendsDataModel>()
                for arr in array{
                    if (arr as AnyObject).isKind(of:NSDictionary.self){
                        let dataModel = FBFriendsDataModel.parseJson(dict: arr )
                        arrData.append(dataModel)
                        
                    }
                }
                model.data = arrData
            }
            
        }
        if let paging = dict["paging"]{
            if(paging as AnyObject).isKind(of: NSDictionary.self){
                let pagModel = FBFriendsPagingModel.parseJson(dict: paging as! Dictionary<String,Any>)
                model.paging = pagModel
            }
        }
        if let summary = dict["summary"]{
            if (summary as AnyObject).isKind(of: NSDictionary.self){
                let dic = summary as! Dictionary<String,Any>
                let summaryModel = FBFriendsSummaryModel.parseJson(dict: dic)
                model.summary=summaryModel
            }
        }
        
        
        return model
    }
    
    class func parseData(data:Data)->FBFriendsModel{
        var model = FBFriendsModel()
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if ((jsonData as AnyObject).isKind(of: NSDictionary.self)){
                model = FBFriendsModel.parseWithDict(dict: jsonData as! Dictionary<String,Any>)
            }
        } catch {
            print(error)
        }
        
        return model
    }
    
    
    
}
class FBFriendsDataModel: NSObject {
    var id:String?
    var name:String?
    var picture:FBPictureModel?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    class func parseJson(dict:Dictionary<String,Any>)->FBFriendsDataModel{
        let model = FBFriendsDataModel()
        model.setValuesForKeys(dict)
        if let pictureDict = dict["picture"]{
            if (pictureDict as AnyObject).isKind(of: NSDictionary.self){
                let pictureModel = FBPictureModel.parseWithDict(dict: pictureDict as! Dictionary<String,Any>)
                model.picture = pictureModel
            }
            
        }
        
        return model
    }
    
    
    
    
}
class FBFriendsPagingModel:NSObject{
    var cursors:FBFriendsCursorsModel?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    class func parseJson(dict:Dictionary<String,Any>)->FBFriendsPagingModel{
        let model = FBFriendsPagingModel()
        model.setValuesForKeys(dict)
        if let cursors = dict["cursors"]{
            if (cursors as AnyObject).isKind(of: NSDictionary.self){
                let dic = cursors as! Dictionary<String,Any>
                let cursorsModel = FBFriendsCursorsModel.parseJson(dict: dic)
                model.cursors = cursorsModel
            }
        }
        
        
        
        return model
    }
    
    
}

class FBFriendsCursorsModel:NSObject{
    var before:String?
    var after:String?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    class func parseJson(dict:Dictionary<String,Any>)->FBFriendsCursorsModel{
        let model = FBFriendsCursorsModel()
        model.setValuesForKeys(dict)
        return model
    }
    
    
}
class FBFriendsSummaryModel: NSObject {
    var total_count:AnyObject?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    class func parseJson(dict:Dictionary<String,Any>)->FBFriendsSummaryModel{
        let model = FBFriendsSummaryModel()
        
        model.setValuesForKeys(dict)
        
        return model
    }
    
    
}

