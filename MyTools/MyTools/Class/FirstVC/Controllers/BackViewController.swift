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
    private var label:UILabel!
    private var lock:NSLock!
    private var ticker = 20
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        automaticallyAdjustsScrollViewInsets = false
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        view.addSubview(btn)
        btn.setTitle("测试", for: .normal)
        btn.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
        }
        let data = ["adsf","fff","eeee"]
        label = UILabel()
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(btn.snp.bottom)
            make.left.equalTo(view.snp.left).offset(50)
            
            
        }
        label.text = data.get(at: 2)
        label.sizeToFit()
        label.backgroundColor = UIColor(hexString: "#FFeeFF", alpha: 1)
        createAttTextLabel()
        lock = NSLock()
        
        let thread1 = Thread(target: self, selector: #selector(saleTickets(thread:)), object: nil)
        thread1.name = "窗口1"
        let thread2 = Thread(target: self, selector: #selector(saleTickets(thread:)), object: nil)
        thread2.name = "窗口2"
        thread1.start()
        thread2.start()
        
        let actView = ActivityView(frame: CGRect(x: 0, y: 0, w: 100, h: 100))
        actView.center = view.center
        actView.titleString = "加载中..."
        view.addSubview(actView)
        
        
        
        
    }
    @objc private func btnAction(){
        self.delegate?.backTest(str: "泄漏测试")
        navigationController?.popViewController(animated: true)
    }
    @objc private func createAttTextLabel(){
        let str = "人生若只如初见，何事悲风秋画扇。\n等闲变却故人心，却道故人心易变。\n骊山语罢清宵半，泪雨霖铃终不怨。\n何如薄幸锦衣郎，比翼连枝当日愿。"
        let attrStr = NSMutableAttributedString(string: str)
        //设置字体和字体范围
        attrStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 30), range: NSMakeRange(0, 3))
        //添加文字颜色
        attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.red ,range: NSMakeRange(17, 7))
        //添加文字背景颜色
        attrStr.addAttribute(NSBackgroundColorAttributeName, value: UIColor.orange, range: NSMakeRange(17, 7))
        //添加下划线
        //let num = NSUnderlineStyle.styleSingle
        attrStr.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(8, 7))
        //attrStr.addAttributes([NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue], range: NSMakeRange(8, 7))
        //attrStr.addAttribute(NSUnderlineStyleAttributeName, value:NSUnderlineStyle.styleThick.rawValue, range: NSMakeRange(8, 7))
        let attLabel = UILabel()
        view.addSubview(attLabel)
        attLabel.snp.makeConstraints {
            [weak self]
            (make) in
            make.left.equalTo((self?.view.snp.left)!).offset(20)
            make.right.equalTo((self?.view.snp.right)!).offset(-20)
            make.top.equalTo((self?.label.snp.bottom)!)
            
        }
        attLabel.backgroundColor = UIColor.green
        attLabel.preferredMaxLayoutWidth = kScreenWidth - 40
        attLabel.sizeToFit()
        attLabel.numberOfLines = 0
        attLabel.attributedText = attrStr
    }
    
    @objc private func saleTickets(thread:Thread){
        while true {
            lock.lock()
            if(ticker<=0){
                lock.unlock()
                let str = "\(String(describing: Thread.current.name!))票卖完了"
                DispatchQueue.main.async {
                    [weak self] in
                    self?.label.text = str
                }
                return
            }
            ticker -= 1
            let str = "\(String(describing: Thread.current.name!))售出 1 张,还剩 \(ticker)"
            print(str)
            DispatchQueue.main.async {
                [weak self] in
                self?.label.text = str
            }
            lock.unlock()
            Thread.sleep(forTimeInterval: TimeInterval(arc4random()%3))
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取点击屏幕的坐标点.
        let touchArray = (touches as NSSet).allObjects
        let touch = touchArray[0] as! UITouch
        let point = touch.location(in: self.view)
        print(touchArray.count)
        print(point.x,point.y)
        
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
