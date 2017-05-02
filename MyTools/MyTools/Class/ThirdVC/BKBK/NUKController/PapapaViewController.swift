//
//  PapapaViewController.swift
//  NUK
//
//  Created by NUK on 16/8/13.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit
class PapapaViewController: UIViewController,ZKDownloaderDelegate,UITableViewDelegate,UITableViewDataSource {
    lazy var dataArray = NSMutableArray()
    var tbView:UITableView?
    var ep_count:String!
    var id:String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.downloaderData()
        self.createTbView()
        ProgressHUD.showOnView(self.view)
    }
    
    
     func downloaderData() {
        let urlString = String(format: "http://picaman.picacomic.com/api/comics/%@/ep/%@", self.id,self.ep_count)
        print(urlString)
        print(NSHomeDirectory())
        let downloader = ZKDownloader()
        downloader.getWithUrl(urlString)
        downloader.delegate = self
        
    }

    
    
    func createTbView(){
        self.automaticallyAdjustsScrollViewInsets = false
        self.tbView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-20), style: .plain)
        self.tbView?.delegate = self
        self.tbView?.dataSource = self
        self.view.addSubview(self.tbView!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PapapaViewController{
    func downloader(_ downloader: ZKDownloader, didFailWithError error: NSError) {
        DispatchQueue.main.async {
            [weak self]in
            ProgressHUD.hideAfterFailOnView(self!.view)
        }
        
        ZKTools.showAlert(error.localizedDescription, onViewController: self)
        
    }
    func downloader(_ download: ZKDownloader, didFinishWithData data: Data?) {
        let jsonData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        if (jsonData as AnyObject).isKind(of: NSArray.self){
            let array = jsonData as! NSArray
            for i in array{
                let dict = i as! Dictionary<String,AnyObject>
                let model = PapapaModel()
                model.setValuesForKeys(dict)
                print(model.url!)
                self.navigationItem.title = model.url!
                self.dataArray.add(model)
            }
            DispatchQueue.main.async(execute: { 
                self.tbView?.reloadData()
                ProgressHUD.hideAfterSuccessOnView(self.view)
            })
        }
    }
}

extension PapapaViewController{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
     @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        KingfisherManager.shared.cache.clearMemoryCache()
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)as? PapapaCell
        if cell == nil {
            cell = PapapaCell(style: .default, reuseIdentifier: cellId)
        }
        let model = self.dataArray[(indexPath as NSIndexPath).row]as! PapapaModel
        print(model.url as Any)
        cell?.configModel(model)
        return cell!
    }
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.dataArray[(indexPath as NSIndexPath).row]as! PapapaModel
        let t =  CGFloat(model.width!) / kScreenWidth
        return CGFloat(model.height!) / t - 20
    }
}




