//
//  ADModel.swift
//  MyTools
//
//  Created by zhangk on 17/3/24.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class ADModel: NSObject {
    var adImageUrl:String!
    var adUrl: String!
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

     class func parseJson(_ data:Data)->ADModel{
        let model = ADModel()
        do{
            let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if jsonData is NSDictionary{
                let dic = jsonData as! Dictionary<String,NSObject>
                model.setValuesForKeys(dic)
            }
        }catch{
            print(error)
        }
        return model
    }
    
}

