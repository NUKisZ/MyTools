//
//  GroupListViewController.swift
//  NUK
//
//  Created by NUK on 16/8/13.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class GroupListViewController: NUKBaseViewController,ZKDownloaderDelegate {

    var id:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func downloaderData() {
        //http://picaman.picacomic.com/api/categories/1/page/1/comics
        let urlString = String(format: "http://picaman.picacomic.com/api/categories/%@/page/%d/comics", self.id,self.curPage)
        let download = ZKDownloader()
        download.getWithUrl(urlString)
        download.delegate = self
        
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
extension GroupListViewController{
    func downloader(_ downloader: ZKDownloader, didFailWithError error: NSError) {
        ZKTools.showAlert(error.localizedDescription, onViewController: self)
    }
    func downloader(_ download: ZKDownloader, didFinishWithData data: Data?) {
        let jsonData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        if (jsonData as AnyObject).isKind(of: NSArray.self){
            if self.curPage == 1 {
                self.dataArray.removeAllObjects()
            }
            let array = jsonData as! NSArray
            for arr in array{
                let dict = arr as! Dictionary<String,AnyObject>
                let model = GroupListModel()
                model.setValuesForKeys(dict)
                self.dataArray.add(model)
                
            }
            DispatchQueue.main.async(execute: { 
                self.tbView?.reloadData()
                self.tbView?.headerView?.endRefreshing()
                self.tbView?.footerView?.endRefreshing()
            })
        }
    }
}
extension GroupListViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "groupListCellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)as? GroupListCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("GroupListCell", owner: nil, options: nil)?.last as? GroupListCell
            
        }
        let model = self.dataArray[(indexPath as NSIndexPath).row]as! GroupListModel
        cell?.config(model)
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        let detailCtrl = DetailViewController()
        let model = self.dataArray[(indexPath as NSIndexPath).row]as! GroupListModel
        detailCtrl.id = "\((model.id)!)"
        self.navigationController?.pushViewController(detailCtrl, animated: true)
    }
}











