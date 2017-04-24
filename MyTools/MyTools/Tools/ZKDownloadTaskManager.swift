//
//  ZKDownloadTask.swift
//  MyTools
//
//  Created by gongrong on 2017/4/24.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
private let kTaskList = "ZKDownloadTaskList"
struct DownloadTask{
    var url:URL
    var localURL:URL?
    var taskIdentifier:Int
    var finished:Bool = false
    init(url:URL,taskIdentifier:Int) {
        self.url = url
        self.taskIdentifier = taskIdentifier
    }
}
enum DownloadTaskNotification:String{
    case Progress = "downloadNotificationProgress"
    case Finish = "downloadNotificationFinish"
}

class ZKDownloadTaskManager: NSObject,URLSessionDownloadDelegate {
    private var session:URLSession?
    var taskList:[DownloadTask] = [DownloadTask]()
    static var sharedInstance:ZKDownloadTaskManager=ZKDownloadTaskManager()
    override init() {
        super.init()
        let config = URLSessionConfiguration.background(withIdentifier: "downloadSession")
        self.session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        self.taskList = [DownloadTask]()
        self.loadTaskList()
        
        
    }
    func unFinishedTask()->[DownloadTask]{
        return taskList.filter({ (task) -> Bool in
            return task.finished == false
        })
    }
    func finishedTask() -> [DownloadTask] {
        return taskList.filter({ (task) -> Bool in
            return task.finished
        })
    }
    func saveTaskList() {
        let jsonArray = NSMutableArray()
        for task in taskList{
            let jsonItem = NSMutableDictionary()
            jsonItem["url"] = task.url.absoluteString
            jsonItem["taskIdentifier"] = NSNumber(value:task.taskIdentifier as Int)
            jsonItem["finished"] = NSNumber(value: task.finished as Bool)
            jsonArray.add(jsonItem)
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
            UserDefaults.standard.set(jsonData, forKey: kTaskList)
            UserDefaults.standard.synchronize()
        } catch  {
        
        }
    }
    func loadTaskList(){
        if let jsonData:Data = UserDefaults.standard.object(forKey: kTaskList) as? Data{
            do {
                
                guard let jsonArray:NSArray = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray else {return}
                for jsonItem in jsonArray{
                    if let item:NSDictionary = jsonItem as? NSDictionary{
                        guard let urlString = item["url"] as? String else {
                            return
                        }
                        guard let taskIdentifier = item["taskIdentifier"] else {
                            return
                        }
                        let downloadTask = DownloadTask(url: URL(string:urlString)!, taskIdentifier: taskIdentifier as! Int)
                        self.taskList.append(downloadTask)
                    }
                }
            } catch  {
                
            }
        }
        
    }
    func newTask(urlString:String) {
        print("task cout: \(ZKDownloadTaskManager.sharedInstance.unFinishedTask().count)")
        if let url = URL(string: urlString){
            let downloadTask = self.session?.dataTask(with: url)
            downloadTask?.resume()
            let task = DownloadTask(url: url as URL, taskIdentifier: (downloadTask?.taskIdentifier)!)
            self.taskList.append(task)
            self.saveTaskList()
            
        }
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        //下载完成后
        var fileName = ""
        for i in 0..<self.taskList.count{
            if self.taskList[i].taskIdentifier == downloadTask.taskIdentifier{
                self.taskList[i].finished=true
                fileName = self.taskList[i].url.lastPathComponent
            }
        }
        if let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let destURL = documentURL.appendingPathComponent(fileName)
            do{
                try FileManager.default.moveItem(at: location, to: destURL)
            }catch{
                
            }
        }
        self.saveTaskList()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DownloadTaskNotification.Finish.rawValue), object: downloadTask.taskIdentifier)
        
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        //下载恢复后
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //下载进度发生变化时
        let progressInfo = ["taskIdentifier":downloadTask.taskIdentifier,"totalBytesWritten":NSNumber(value: totalBytesWritten),"totalBytesExpectedToWrite":NSNumber(value:totalBytesExpectedToWrite)] as [String : Any]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DownloadTaskNotification.Progress.rawValue), object: progressInfo)
        
        
    }

}
