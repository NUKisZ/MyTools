//
//  DownloadTaskViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/4/24.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class DownloadTaskViewController: BaseViewController {
    
    fileprivate var tbView :UITableView?
    fileprivate var taskList:[DownloadTask]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTableView()
    }
    func createTableView(){
        navigationController?.automaticallyAdjustsScrollViewInsets = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightItemAction))
        tbView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-20), style: .plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        view.addSubview(tbView!)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: DownloadTaskNotification.Finish.rawValue), object: nil)
    }
    func reloadData(){
        taskList = ZKDownloadTaskManager.sharedInstance.unFinishedTask()
        self.tbView?.reloadData()
    }
    func rightItemAction(){
        let viewController = NewTaskViewController()
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadData()
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
extension DownloadTaskViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskList == nil ? 0 : self.taskList!.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)as? DownloadCell
        if (cell == nil ){
            cell = DownloadCell(style: .default, reuseIdentifier: cellID)
        }
        cell?.updateData(task: (self.taskList?[indexPath.row])!)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.taskList?[indexPath.row] ?? "空")
    }
    
}
