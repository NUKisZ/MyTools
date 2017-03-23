//
//  ZKDownloader.swift
//
//
//  Created by NUK on 16/8/16.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit
public enum ZKDownloaderType:Int{
    case `default` = 0
}
protocol ZKDownloaderDelegate:NSObjectProtocol{
    func downloader(_ download:ZKDownloader,didFailWithError error:NSError)
    func downloader(_ download:ZKDownloader,didFinishWithData data:Data?)
}
class ZKDownloader: NSObject {
    
    weak var delegate:ZKDownloaderDelegate?
    //var type:ZKDownloaderType?
    var type:Int?
    
    func getWithUrl(_ urlString:String){

        
        
        let session = URLSession.shared
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil{
                self.delegate?.downloader(self, didFailWithError: error as! NSError)
            }else{
                //根据状态码区分
                let httpRes = response as! HTTPURLResponse
                if httpRes.statusCode == 200{
                    //正确返回
                    self.delegate?.downloader(self, didFinishWithData: data)
                    
                    
                    
                }else {
                    //500之类的错误
                    //print(httpRes.statusCode)
                    let erro = NSError(domain: "下载错误", code: httpRes.statusCode, userInfo: nil)
                    self.delegate?.downloader(self, didFailWithError: erro)
                }
            }
        }
        task.resume()
        
    }
    func postWithUrl(urlString:String,params:[String:String]){
        let url = URL(string: urlString)
        var request = URLRequest(url: url! as URL)
        let dict = NSDictionary(dictionary: params)
        var paramString = String()
        
        if dict.allKeys.count > 0 {
            
            for i in 0..<dict.allKeys.count {
                //获取字典的每一个键值对
                let key = dict.allKeys[i] as! String
                let value = dict[key] as! String
                
                if i == 0 {
                    paramString = paramString.appendingFormat("%@=%@", key, value)
                }else{
                    paramString = paramString.appendingFormat("&%@=%@", key, value)
                }
            }
            
        }
        
        let data = paramString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        request.httpBody = data
        request.httpMethod = "POST"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let err = error {
                //下载失败
                self.delegate?.downloader(self, didFailWithError: err as NSError)
            }else{
                
                let httpRes = response as! HTTPURLResponse
                if httpRes.statusCode == 200 {
                    //下载成功
                    
                    self.delegate?.downloader(self, didFinishWithData: data)
                    
                }else{
                    let erro = NSError(domain: "下载错误", code: httpRes.statusCode, userInfo: nil)
                    self.delegate?.downloader(self, didFailWithError: erro)
                }
                
            }
        }
        task.resume()
        
    }

    

}
