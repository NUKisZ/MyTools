//
//  TaskManager.swift
//  downloader
//
//  Created by icafe on 12/22/15.
//  Copyright © 2015 swiftcafe. All rights reserved.
//

import UIKit


class TaskManager: NSObject, URLSessionDownloadDelegate {

    fileprivate var session:Foundation.URLSession?
    
    var taskList:[DownloadTask] = [DownloadTask]()
    
    static var sharedInstance:TaskManager = TaskManager()
    
    override init() {
        
        super.init()
        
        let config = URLSessionConfiguration.background(withIdentifier: "downloadSession")
        self.session = Foundation.URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        self.taskList = [DownloadTask]()
        self.loadTaskList()

    }
    
    func unFinishedTask() -> [DownloadTask] {
        
        return taskList.filter{ task in
            
            return task.finished == false
            
        }
        
    }
    
    func finishedTask() -> [DownloadTask] {
        
        return taskList.filter { task in
            
            return task.finished
            
        }
        
    }
    
    func saveTaskList() {
        
        let jsonArray = NSMutableArray()

        for task in taskList {
            
            let jsonItem = NSMutableDictionary()
            jsonItem["url"] = task.url.absoluteString
            jsonItem["taskIdentifier"] = NSNumber(value: task.taskIdentifier as Int)
            jsonItem["finished"] = NSNumber(value: task.finished as Bool)
            
            jsonArray.add(jsonItem)
            
        }

        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            UserDefaults.standard.set(jsonData, forKey: "taskList")
            UserDefaults.standard.synchronize()
            
        }catch {
            
        }
        
    }
    
    func loadTaskList() {
        
        if let jsonData:Data = UserDefaults.standard.object(forKey: "taskList") as? Data {
            
            do {
                
                guard let jsonArray:NSArray = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray else { return }
                
                for jsonItem in jsonArray {
                    
                    if let item:NSDictionary = jsonItem as? NSDictionary {
                        
                        guard let urlstring = item["url"] as? String else { return }
                        guard let taskIdentifier = item["taskIdentifier"] else { return }
                        
                        let downloadTask = DownloadTask(url: URL(string: urlstring)!, taskIdentifier: taskIdentifier as! Int)
                        self.taskList.append(downloadTask)
                        
                    }
                    
                }
                
            } catch {
                
            }
            
        }
        
    }
    
    func newTask(_ url: String) {

        print("task cout: \(TaskManager.sharedInstance.unFinishedTask().count)")
        
        if let url = URL(string: url) {
            
            let downloadTask = self.session?.downloadTask(with: url)
            downloadTask?.resume()
            let task = DownloadTask(url: url, taskIdentifier: downloadTask!.taskIdentifier)
            self.taskList.append(task)
            self.saveTaskList()
            
        }

            
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        var fileName = ""
        
        for i in 0 ..< self.taskList.count {
            
            if self.taskList[i].taskIdentifier == downloadTask.taskIdentifier {

                self.taskList[i].finished = true
                fileName = self.taskList[i].url.lastPathComponent
                
            }
            
        }
        
        if let documentURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first {
            
            let destURL = documentURL.appendingPathComponent(fileName)
            do {

                try FileManager.default.moveItem(at: location, to: destURL)
                
            } catch {
                
            }

            
        }

        
        print(location)
        
        self.saveTaskList()
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: DownloadTaskNotification.Finish.rawValue), object: downloadTask.taskIdentifier)
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {

        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let progressInfo:[String:Any] = ["taskIdentifier": downloadTask.taskIdentifier,
                            "totalBytesWritten": NSNumber(value: totalBytesWritten as Int64),
                            "totalBytesExpectedToWrite": NSNumber(value: totalBytesExpectedToWrite as Int64)]

        NotificationCenter.default.post(name: Notification.Name(rawValue: DownloadTaskNotification.Progress.rawValue), object: progressInfo)

    }
    
}
