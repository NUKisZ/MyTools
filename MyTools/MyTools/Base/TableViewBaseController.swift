//
//  TableViewBaseController.swift
//  MyTools
//
//  Created by gongrong on 2017/5/10.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class TableViewBaseController: BaseViewController {
    lazy var dataArray=NSMutableArray()
    var tableView:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    public func createTableView(frame:CGRect,style:UITableViewStyle,separatorStyle:UITableViewCellSeparatorStyle){
        tableView = UITableView(frame: frame, style: style)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = separatorStyle
        view.addSubview(tableView!)
        
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
extension TableViewBaseController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("子类需要继承父类numberOfRowsInSection")
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("子类需要继承父类cellForRowAt")
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("子类需要继承父类didSelectRowAt")
    }
}
