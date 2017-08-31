//
//  BaseViewController.swift
//  MyTools
//
//  Created by zhangk on 17/3/23.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {
    
    
    

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        navigationItem.title = "\(type(of: self))"
    }
    
    public func initNavTitle(titleString:String){
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.colorWithHexStringAndAlpha(hex: "FFFFFF", alpha: 1.0)];
        navigationItem.title = titleString
    }
    public func initNavBack(){
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: ""), for: .normal)
        backBtn.addTarget(self, action: #selector(bafseBackAction), for: .touchUpInside)
        backBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
    public func bafseBackAction(){
        if((presentingViewController) != nil){
            let views = navigationController?.viewControllers
            if((views?.count)!>1){
                if((views?[(views?.count)!-1])!==self){
                    navigationController?.popViewController(animated: true)
                }
            }
            dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    public func changeNavBackGroundColor(leftColor:String,rightColor:String){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let navBGView = UIView(frame: CGRect(x: 0, y: 0, w: kScreenWidth, h: 64))
        view.addSubview(navBGView)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = navBGView.bounds
        navBGView.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.colors = [UIColor.colorWithHexStringAndAlpha(hex: leftColor, alpha: 1.0).cgColor,UIColor.colorWithHexStringAndAlpha(hex: rightColor, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.5,1.0]
    }
    
    deinit {
        print("\(type(of: self))被释放了")
    }
    override open func didReceiveMemoryWarning() {
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
