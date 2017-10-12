//
//  PingViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/8/7.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class PingViewController: BaseViewController {

    var textFile:UITextField!
    var pingLabel:UILabel!
    var pingHost:UILabel!
    var btn:UIButton!
    var server:PPSPingServices!
    var isPing:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        textFile = UITextField(frame: CGRect(x: 20, y: 64, width: 200, height: 30))
        textFile.text = "www.baidu.com"
        textFile.placeholder = "www.baidu.com"
        textFile.backgroundColor = UIColor.gray
        textFile.layer.cornerRadius = 5
        textFile.layer.masksToBounds = true
        view.addSubview(textFile)
        btn = ZKTools.createButton(CGRect(x: 240, y: 64, w: 80, h: 30), title: "ping", imageName: nil, bgImageName: nil, target: self, action: #selector(pingClick))
        view.addSubview(btn)
        pingLabel = UILabel(frame: CGRect(x: 20, y: 100, w: 200, h: 20))
        pingLabel.backgroundColor = UIColor.cyan
        pingLabel.textAlignment = .center
        view.addSubview(pingLabel)
        pingHost = UILabel(frame: CGRect(x: 20, y: 130, w: 200, h: 20))
        pingHost.backgroundColor = UIColor.cyan
        pingHost.textAlignment = .center
        view.addSubview(pingHost)
        
        
        
        

        // Do any additional setup after loading the view.
    }
    func pingClick(){
        
        if(isPing){
            isPing = false
            btn.setTitle("cancel", for: .normal)
            server = PPSPingServices.service(withAddress: textFile.text)
            server?.start(callbackHandler: {
                [weak self]
                (summary, dict) in
                if let summ = summary{
                    DispatchQueue.main.async {
                        self?.pingLabel.text = "Ping:\(Int(summ.rtt))ms"
                        if let host = summ.host{
                            self?.pingHost.text = "Host:\(host)"
                        }
                    }
                }
            })
        }else{
            isPing = true
            btn.setTitle("ping", for: .normal)
            server.cancel()
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
