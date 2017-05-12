//
//  SendMessageButton.swift
//  sendMessageBtn
//
//  Created by zhangk on 16/11/25.
//  Copyright © 2016年 zhangk. All rights reserved.
//

import UIKit
class SendMessageButton: UIButton {
    private var countdownTimer:Timer?
    private var intervalTime:Int=10
    private var isCounting:Bool = false{
        willSet{
            if newValue{
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                remainingSecods = intervalTime
                setTitleColor(UIColor.gray, for: .normal)
                isEnabled = false
            }else{
                countdownTimer?.invalidate()
                countdownTimer = nil
                isEnabled = true
                setTitleColor(UIColor.white, for: .normal)
            }
            isEnabled = !newValue
        }
    }
    private var remainingSecods:Int = 0{
        willSet{
            setTitle("\(newValue)秒", for: .normal)
            if newValue <= 0{
                setTitle("获取验证码", for: .normal)
                isCounting = false
            }else{
                isEnabled = false
                setTitleColor(UIColor.gray, for: .normal)
            }
        }
    }
    @objc private func updateTime(timer:Timer) {
        remainingSecods = remainingSecods-1
    }
    init(frame: CGRect,countdownTime:Int){
        super.init(frame: frame)
        intervalTime = countdownTime
        setTitle("获取验证码", for: .normal)
        setTitleColor(UIColor.gray, for: .normal)
        addTarget(self, action: #selector(codeBtnAction), for: .touchUpInside)
        //titleLabel?.font = UIFont.systemFont(ofSize: 10)
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    @objc private func codeBtnAction(){
        isEnabled = false
        isCounting = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
