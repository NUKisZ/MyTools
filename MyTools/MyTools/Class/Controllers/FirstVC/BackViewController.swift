//
//  BackViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/4/24.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class BackViewController: BaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //禁用返回手势
        //navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled=false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
