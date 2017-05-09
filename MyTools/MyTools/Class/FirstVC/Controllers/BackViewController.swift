//
//  BackViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/4/24.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
protocol BackViewControllerDelegate:NSObjectProtocol {
    func backTest(str:String)
}

class BackViewController: BaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //禁用返回手势
        //navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled=false
    }
    weak var delegate:BackViewControllerDelegate?

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
        let data = ["adsf","fff","eeee"]
        let label = UILabel()
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(btn.snp.bottom)
            make.left.equalTo(view.snp.left).offset(50)
            
            
        }
        label.text = data.get(at: 2)
        label.backgroundColor = UIColor(hexString: "#FFeeFF", alpha: 1)
        
        
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
