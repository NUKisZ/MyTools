//
//  BackViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/4/24.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
protocol BackViewControllerDelegate {
    func backTest(str:String)
}

class BackViewController: BaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //禁用返回手势
        //navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled=false
    }
     var delegate:BackViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        view.addSubview(btn)
        btn.setTitle("强引用测试", for: .normal)
        btn.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
        }
    }
    @objc private func btnAction(){
        self.delegate?.backTest(str: "泄漏测试")
        navigationController?.popViewController(animated: true)
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
