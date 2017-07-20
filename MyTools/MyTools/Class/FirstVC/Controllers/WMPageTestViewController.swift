//
//  WMPageTestViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/7/20.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class WMPageTestViewController: WMPageController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.titleSizeNormal = 14;
        self.titleSizeSelected = 14;
        self.menuViewStyle = .line;
        //        self.menuItemWidth = 108;
        self.menuHeight = 36;
        self.viewFrame = CGRect(x: 0, y: 64, w: kScreenWidth, h: kScreenHeight)
        self.progressColor = UIColor.colorWithHexStringAndAlpha(hex: "20A2EA", alpha: 1.0);
        self.progressWidth = 18;
        self.progressHeight = 2;
        //        self.itemMargin = 11;
        self.menuBGColor = UIColor.white;
        self.titleColorSelected = UIColor.colorWithHexStringAndAlpha(hex: "20A2EA", alpha: 1.0);
        self.titleColorNormal = UIColor.colorWithHexStringAndAlpha(hex: "A7A7A7", alpha: 1.0);

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension WMPageTestViewController{
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return "\(index)"
    }
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return 2;
    }
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 1{
            return WebViewController()
        }else{
            return SIMInfoViewController()
        }
    }
}
