//
//  PhoneCodeViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/5/12.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class PhoneCodeViewController: BaseViewController {
    
    private lazy var sendMessageBtn:SendMessageButton = {
      let btn = SendMessageButton(frame: CGRect(x: 50, y: 150, w: 100, h: 20), countdownTime: 5)
        btn.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        btn.setTitle("发送", for: .normal)
        btn.backgroundColor = UIColor.red
        return btn
    }()
    private lazy var messageLabel:UILabel = {
        let label = ZKTools.createLabel(CGRect(x: 50, y: 100, w: 100, h: 20), title: "0次", textAlignment: .center, font: nil, textColor: UIColor.black)
        label.backgroundColor = UIColor.gray
        return label
    }()
    private lazy var sendMessageCount:Int=0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(messageLabel)
        view.addSubview(sendMessageBtn)
    }
    @objc private func sendAction(){
        sendMessageCount += 1
        messageLabel.text = "\(sendMessageCount)次"
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
