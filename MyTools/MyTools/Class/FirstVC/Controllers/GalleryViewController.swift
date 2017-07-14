//
//  GalleryViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/7/14.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class GalleryViewController: BaseViewController {

    //普通的flow流式布局
    var flowLayout:UICollectionViewFlowLayout!
    //自定义的线性布局
    var linearLayput:LinearCollectionViewLayout!
    
    var collectionView:UICollectionView!
    
    //重用的单元格的Identifier
    let CellIdentifier = "myCell"
    
    //所有书籍数据
    var images = ["c#.png", "html.png", "java.png", "js.png", "php.png",
                  "react.png", "ruby.png", "swift.png", "xcode.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let changBtn = ZKTools.createButton(CGRect(x: 0, y: 0, w: 40, h: 25), title: "切换", imageName: nil, bgImageName: nil, target: self, action: #selector(changeClick(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: changBtn)
        automaticallyAdjustsScrollViewInsets = false;
        //初始化Collection View
        initCollectionView()
        
        //注册tap点击事件
        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action: #selector(handleTap(_:)))
        collectionView.addGestureRecognizer(tapRecognizer)
    }
    
    private func initCollectionView() {
        //初始化flow布局
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 60, height: 60)
        flowLayout.sectionInset = UIEdgeInsets(top: 74, left: 0, bottom: 0, right: 0)
        
        //初始化自定义布局
        linearLayput = LinearCollectionViewLayout()
        
        //初始化Collection View
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: linearLayput)
        
        //Collection View代理设置
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        //注册重用的单元格
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier)
        //将Collection View添加到主视图中
        view.addSubview(collectionView)
    }
    
    //点击手势响应
    func handleTap(_ sender:UITapGestureRecognizer){
        if sender.state == UIGestureRecognizerState.ended{
            let tapPoint = sender.location(in: self.collectionView)
            //点击的是单元格元素
            if let  indexPath = self.collectionView.indexPathForItem(at: tapPoint) {
                //通过performBatchUpdates对collectionView中的元素进行批量的插入，删除，移动等操作
                //同时该方法触发collectionView所对应的layout的对应的动画。
                self.collectionView.performBatchUpdates({ () -> Void in
                    self.collectionView.deleteItems(at: [indexPath])
                    self.images.remove(at: indexPath.row)
                }, completion: nil)
                
            }
                //点击的是空白位置
            else{
                //新元素插入的位置（开头）
                let index = 0
                images.insert("xcode.png", at: index)
                self.collectionView.insertItems(at: [IndexPath(item: index, section: 0)])
            }
        }
    }
    
    //切换布局样式
    func changeClick(_ sender: Any) {
        self.collectionView.collectionViewLayout.invalidateLayout()
        //交替切换新布局
        let newLayout = collectionView.collectionViewLayout
            .isKind(of: LinearCollectionViewLayout.self) ? flowLayout : linearLayput
        collectionView.setCollectionViewLayout(newLayout!, animated: true)
        collectionView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//Collection View数据源协议相关方法
extension GalleryViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    //获取分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //获取每个分区里单元格数量
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    //返回每个单元格视图
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取重用的单元格
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            CellIdentifier, for: indexPath) as! GalleryCollectionViewCell
        //设置内部显示的图片
        cell.imageView.image = UIImage(named: images[indexPath.item])
        return cell
    }
}
