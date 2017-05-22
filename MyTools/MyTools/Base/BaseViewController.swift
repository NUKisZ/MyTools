//
//  BaseViewController.swift
//  MyTools
//
//  Created by zhangk on 17/3/23.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        navigationItem.title = "\(type(of: self))"
    }
    deinit {
        print("\(type(of: self))被释放了")
    }
    override open func didReceiveMemoryWarning() {
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
