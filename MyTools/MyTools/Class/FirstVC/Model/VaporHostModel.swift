//
//  VaporHostModel.swift
//  MyTools
//
//  Created by gongrong on 2017/8/25.
//  Copyright © 2017年 NUK. All rights reserved.
//

import UIKit

class VaporHostModel: NSObject {

    var message:String?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    class func parseJson(data:Data)->VaporHostModel{
        do{
            let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if (jsonData as AnyObject).isKind(of:NSDictionary.self){
                let dict = jsonData as! Dictionary<String,AnyObject>
                let model  = VaporHostModel()
                model.setValuesForKeys(dict)
                return model
            }
        }catch{
            print(error)
        }
        return VaporHostModel()
    }
}
