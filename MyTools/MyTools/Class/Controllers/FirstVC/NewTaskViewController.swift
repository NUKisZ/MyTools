//
//  NewTaskViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/4/24.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class NewTaskViewController: BaseViewController {
    
    var textView:UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "添加任务"
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下载", style: UIBarButtonItemStyle.plain, target: self, action: #selector(add))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(close))
        
        self.textView = UITextView(frame: CGRect(x: 10, y: 10, width: self.view.frame.size.width-20, height: 250))
        self.textView?.layer.borderWidth = 1
        self.textView?.layer.borderColor = UIColor.gray.cgColor
        self.textView?.layer.cornerRadius = 5
        self.textView?.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(self.textView!)
    }
    func close() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func add() {
        //TaskManager.sharedInstance.newTask(self.textView!.text)
        ZKDownloadTaskManager.sharedInstance.newTask(urlString: self.textView!.text)
        self.dismiss(animated: true, completion: nil)
        
        
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
