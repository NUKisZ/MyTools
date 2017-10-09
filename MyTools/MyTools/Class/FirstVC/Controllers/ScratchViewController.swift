//
//  ScratchViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/7/14.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class ScratchViewController: BaseViewController {
    
    fileprivate var label:UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        label = ZKTools.createLabel(CGRect(x: 20, y: 200, w: 200, h: 25), title: nil, textAlignment: .center, font: nil, textColor: nil)
        view.addSubview(label)
        //创建刮刮卡组件
        let scratchCard = ScratchCard(frame: CGRect(x:20, y:70, width:241, height:106),couponImage: UIImage(named: "coupon.png")!,maskImage: UIImage(named: "mask.png")!)
        //设置代理
        scratchCard.delegate = self
        self.view.addSubview(scratchCard)
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 50, y: 300, w: 50, h: 50)
        btn.setTitle("下一面", for: .normal)
        btn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        view.addSubview(btn)
    }
    func nextAction(){
        let vc = GPSViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
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
extension ScratchViewController:ScratchCardDelegate{
    //滑动开始
    func scratchBegan(point: CGPoint) {
        print("开始刮奖：\(point)")
    }
    
    //滑动过程
    func scratchMoved(progress: Float) {
        print("当前进度：\(progress)")
        
        //显示百分比
        let percent = String(format: "%.1f", progress * 100)
        label.text = "刮开了：\(percent)%"
    }
    
    //滑动结束
    func scratchEnded(point: CGPoint) {
        print("停止刮奖：\(point)")
    }
}
