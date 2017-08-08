//
//  View+ShakeViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/8/8.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class ViewShakeViewController: BaseViewController {
    var textView:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView = UITextView()
        textView.frame = CGRect(x: 20, y: 84, w: 150, h: 30)
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.masksToBounds = true
        view.addSubview(textView)
        let horizontalBtn = UIButton(type: .system)
        horizontalBtn.frame = CGRect(x: 20, y: 144, w: 80, h: 30)
        horizontalBtn.setTitle("水平抖动", for: .normal)
        horizontalBtn.addTarget(self, action: #selector(horizontalClick), for: .touchUpInside)
        view.addSubview(horizontalBtn)
        
        let vertical = UIButton(type: .system)
        vertical.frame = CGRect(x: 150, y: 144, w: 80, h: 30)
        vertical.setTitle("垂直抖动", for: .normal)
        vertical.addTarget(self, action: #selector(verticalClick), for: .touchUpInside)
        view.addSubview(vertical)
    }

    @objc private func horizontalClick(){
        textView.shake()
    }
    @objc private func verticalClick(){
        textView.shake(direction: .vertical, times: 10, interval: 0.2, delta: 3) {
            print("结束")
        }
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
