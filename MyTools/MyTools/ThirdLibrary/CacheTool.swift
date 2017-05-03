//
//  CacheTool.swift
//  NUK
//
//  Created by NUK on 16/8/13.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class CacheTool: NSObject {
    
    // 计算缓存大小
    static var cacheSize: String{
        get{
            let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
            let fileManager = FileManager.default
            
            func caculateCache() -> Float{
                var total: Float = 0
                if fileManager.fileExists(atPath: basePath!){
                    let childrenPath = fileManager.subpaths(atPath: basePath!)
                    if childrenPath != nil{
                        for path in childrenPath!{
                            let childPath = (basePath! + "/") + path
                            do{
                                let attr = try fileManager.attributesOfItem(atPath: childPath)
                                
                                let fileSize = attr[FileAttributeKey.size] as! Float
                                total += fileSize
                                
                            }catch _{
                                
                            }
                        }
                    }
                }
                
                return total
            }
            
            
            let totalCache = caculateCache()
            return NSString(format: "%.2f MB", totalCache / 1024.0 / 1024.0 ) as String
        }
    }
    
    // 清除缓存
    class func clearCache() -> Bool{
        var result = true
        let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: basePath!){
            let childrenPath = fileManager.subpaths(atPath: basePath!)
            for childPath in childrenPath!{
                let cachePath = ((basePath)! + "/") + childPath
                do{
                    try fileManager.removeItem(atPath: cachePath)
                }catch _{
                    if Platform.isSimulator{
                        result = false
                    }else{
                        result = true
                    }
                    
                }
            }
        }
        
        return result
    }

}
