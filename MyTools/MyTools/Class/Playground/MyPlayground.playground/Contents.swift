//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
var r = arc4random()%4
var str = "Hello, playground"
var ss = "aaa"
var i = 4
var j = 5
var k = i + j
let btn = UIButton(type: .system)
btn.tag = 99
print(btn.tag)
print(UIFont.Weight.medium)

class SView :UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
let sView = SView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
sView.backgroundColor = UIColor.red
PlaygroundPage.current.liveView = sView
