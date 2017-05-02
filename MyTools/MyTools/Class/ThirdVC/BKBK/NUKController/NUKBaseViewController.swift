//
//  NUKBaseViewController.swift
//  NUK
//
//  Created by NUK on 16/8/13.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class NUKBaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var dataArray = NSMutableArray()
    var tbView:UITableView?
    var curPage:Int = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.downloaderData()
        self.createTableView()
        self.view.backgroundColor = UIColor.white
        
    }

    func downloaderData(){
        
    }
    func createTableView(){
        self.automaticallyAdjustsScrollViewInsets = false
        self.tbView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-64), style: .plain)
        self.tbView?.delegate = self
        self.tbView?.dataSource = self
        self.view.addSubview(self.tbView!)
        self.addHeader()
        self.addFooter()
        
        
    }
    
    func addHeader(){
        if self.tbView?.headerView == nil {
            self.tbView?.headerView = XWRefreshNormalHeader(target: self, action: #selector(loadFirstPage))
        }
    }
    func addFooter(){
        if self.tbView?.footerView == nil {
            self.tbView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(loadNextPage))
        }
    }
    func loadFirstPage(){
        self.curPage = 1
        self.downloaderData()
    }
    func loadNextPage(){
        self.curPage += 1
        self.downloaderData()
        
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
extension NUKBaseViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("子类需要实现numberOfRowsInSection")
        return 0
    }
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("子类需要实现cellForRowAtIndexPath")
        return UITableViewCell()
    }
}




