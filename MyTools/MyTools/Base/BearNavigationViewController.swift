//
//  BearNavigationViewController.swift
//  barstyle
//
//  Created by gongrong on 2017/8/7.
//  Copyright © 2017年 张坤. All rights reserved.
//

import UIKit

class BearNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //就是这两个方法
    override var childViewControllerForStatusBarStyle: UIViewController?{
        return self.topViewController
    }
    override var childViewControllerForStatusBarHidden: UIViewController?{
        return self.topViewController
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
