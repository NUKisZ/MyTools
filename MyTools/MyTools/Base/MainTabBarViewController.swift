//
//  MainTabBarViewController.swift
//  MengWuShe
//
//  Created by zhangk on 16/10/17.
//  Copyright © 2016年 zhangk. All rights reserved.
//

import UIKit
class MainTabBarViewController: UITabBarController {
    private var beforeTag = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createViewControllers()
    }
    override func loadView() {
        super.loadView()
        var i = 0
        for tabbarItemButton in tabBar.subviews {
            if (tabbarItemButton.isKind(of: NSClassFromString("UITabBarButton")!)){
                tabbarItemButton.tag = i;
                i = i + 1
                let btn = tabbarItemButton as! UIButton
                btn.addTarget(self, action: #selector(tabbarButtonClick(tabbarBtn:)), for: .touchUpInside)
                
            }
        }
    }
    func tabbarButtonClick(tabbarBtn:UIButton){
        
    }
    private func createViewControllers() {
        
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 11),NSForegroundColorAttributeName:UIColor.colorWithRGBA(red: 44, green: 185, blue: 176, alpha: 1.0)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 11),NSForegroundColorAttributeName:UIColor.colorWithRGBA(red: 44, green: 185, blue: 176, alpha: 1.0)], for: .selected)
        
        //标题
        let titleArray = ["一","二","三"]
        
        //图片
        let imageArray = ["home_selected","all_selected","myinfo_selected"]
        //选中时的图片
        let selectImageArray = ["home_unselected","all_unselected","myinfo_unselected"]
        //视图控制器
        //let ctrlNameArray = ["MyTools.FirstViewController","MyTools.SecondViewController","MyTools.ThirdViewController"]
        let ctrlNameArray = ["MyTools.FirstViewController","MyTools.SecondViewController","MyTools.BKHomeViewController"]
        
        
        var array = Array<UINavigationController>()
        //循环创建视图控制器
        for i in 0..<titleArray.count{
            //视图控制器
            let clsName = ctrlNameArray[i]
            let cls = NSClassFromString(clsName) as! UIViewController.Type
            let vc = cls.init()
            vc.tabBarItem.title = titleArray[i]
            
            
            tabBar.tintColor = UIColor(colorLiteralRed: 225/255.0, green: 105/255.0, blue: 144/255.0, alpha: 1.0)
            vc.tabBarItem.image = UIImage(named: imageArray[i])?.withRenderingMode(.alwaysOriginal)
            vc.tabBarController?.tabBar.backgroundColor = UIColor.black
            
            vc.tabBarItem.selectedImage = UIImage(named: selectImageArray[i])?.withRenderingMode(.alwaysOriginal)
            
            
            
            //导航
            let navCtrl = RTRootNavigationController(rootViewController: vc)
            //let navCtrl = BearNavigationViewController(rootViewController: vc)
            array.append(navCtrl)
            
            
        }
        self.viewControllers = array
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
