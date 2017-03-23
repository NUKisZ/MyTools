//
//  FirstViewController.swift
//  MyTools
//
//  Created by zhangk on 17/3/23.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        download()
        
        
    }
    fileprivate func download(){
        let download = ZKDownloader()
        download.delegate = self
        download.getWithUrl("https://uilucky.com/data/videoData.json")
        download.type=1
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension FirstViewController:ZKDownloaderDelegate{
    func downloader(_ download: ZKDownloader, didFailWithError error: NSError) {
        print(error)
    }
    func downloader(_ download: ZKDownloader, didFinishWithData data: Data?) {
        if download.type == 1 {
            print(ZKTools.stringWithData(data: data!))
        }
    }
}
