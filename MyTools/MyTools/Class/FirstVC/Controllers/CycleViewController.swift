//
//  ViewController.swift
//  hangge_1314
//
//  Created by hangge on 16/9/24.
//  Copyright © 2016年 hangge.com. All rights reserved.
//

import UIKit

@available(iOS 8.2, *)
class CycleViewController: BaseViewController, SliderGalleryControllerDelegate {
    
    //获取屏幕宽度
    let screenWidth =  UIScreen.main.bounds.size.width
    
    //图片轮播组件
    var sliderGallery : SliderGalleryController!
    
    //图片集合
    var images = ["http://bizhi.zhuoku.com/bizhi2008/0516/3d/3d_desktop_13.jpg",
                  "http://tupian.enterdesk.com/2012/1015/zyz/03/5.jpg",
                  "http://img.web07.cn/UpImg/Desk/201301/12/desk230393121053551.jpg",
                  "http://wallpaper.160.com/Wallpaper/Image/1280_960/1280_960_37227.jpg",
                  "http://bizhi.zhuoku.com/wall/jie/20061124/cartoon2/cartoon014.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        //初始化图片轮播组件
        sliderGallery = SliderGalleryController()
        sliderGallery.delegate = self
        sliderGallery.view.frame = CGRect(x: 10, y: 64, width: screenWidth-20,
                                          height: (screenWidth-20)/4*3);
        
        //将图片轮播组件添加到当前视图
        self.addChildViewController(sliderGallery)
        self.view.addSubview(sliderGallery.view)
        
        //添加组件的点击事件
        let tap = UITapGestureRecognizer(target: self,
                        action: #selector(handleTapAction(_:)))
        sliderGallery.view.addGestureRecognizer(tap)
        let reloadDataBtn = ZKTools.createButton(CGRect(x: sliderGallery.view.centerX, y: sliderGallery.view.frame.maxY, w: 50, h: 30), title: "刷新", imageName: nil, bgImageName: nil, target: self, action: #selector(reloadBtnTap))
        view.addSubview(reloadDataBtn)
    }
    
    //图片轮播组件协议方法：获取内部scrollView尺寸
    func galleryScrollerViewSize() -> CGSize {
        return CGSize(width: screenWidth-20, height: (screenWidth-20)/4*3)
    }
    
    //图片轮播组件协议方法：获取数据集合
    func galleryDataSource() -> [String] {
        return images
    }

    //点击事件响应
    func handleTapAction(_ tap:UITapGestureRecognizer)->Void{
        //获取图片索引值
        let index = sliderGallery.currentIndex
        //弹出索引信息
        let alertController = UIAlertController(title: "您点击的图片索引是：",
                                                message: "\(index)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //“刷新数据”按钮点击
    func reloadBtnTap() {
        images = ["https://www.uilucky.com/AppData/images/WechatIMG1.jpeg",
                  "https://www.uilucky.com/AppData/images/WechatIMG3.jpeg",
                  "https://www.uilucky.com/AppData/images/WechatIMG7.jpeg",
                  "https://www.uilucky.com/AppData/images/WechatIMG10.jpeg"]
        sliderGallery.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

