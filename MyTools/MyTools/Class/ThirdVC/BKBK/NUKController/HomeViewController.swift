//
//  HomeViewController.swift
//  NUK
//
//  Created by NUK on 16/8/13.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class BKHomeViewController: BaseViewController,ZKDownloaderDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    fileprivate var collView:UICollectionView?
    fileprivate lazy var dataArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.createCollView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "清除缓存", style: UIBarButtonItemStyle.done, target: self, action: #selector(clearCache))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "刷新", style: .done, target: self, action: #selector(reloadNewDataAction))
        downloaderData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //设置信号栏状态颜色
        //UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    @objc private func reloadNewDataAction(){
        downloaderData()
    }
    @objc private func clearCache(){
        let alert = UIAlertController(title: "提示", message: "缓存大小为\(CacheTool.cacheSize)", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "确定", style: .default) { (alert) in
            var message = "清除成功"
            if CacheTool.clearCache() {
                message = "清除失败"
            }
            let alert = UIAlertController(title: "提示", message: message , preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
        alert.addAction(action)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    private func downloaderData() {
        let urlString = "http://picaman.picacomic.com/api/categories"
        let download = ZKDownloader()
        download.getWithUrl(urlString)
        download.delegate = self
    }
    private func createCollView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2)
        self.automaticallyAdjustsScrollViewInsets = false
        self.collView = UICollectionView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-64), collectionViewLayout: layout)
        
        self.collView?.delegate = self
        self.collView?.dataSource = self
        self.collView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        self.collView?.backgroundColor = UIColor.white
        self.view.addSubview(self.collView!)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension BKHomeViewController{
    func downloader(_ download: ZKDownloader, didFailWithError error: NSError) {
        collView?.headerView?.endRefreshing()
        ZKTools.showAlert(error.localizedDescription, onViewController: self)
    }
    func downloader(_ download: ZKDownloader, didFinishWithData data: Data?) {
        let jsonData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        if (jsonData as AnyObject).isKind(of: NSArray.self){
            let array = jsonData as! NSArray
            dataArray.removeAllObjects()
            for arrayDict in array{
                let dict = arrayDict as! Dictionary<String,AnyObject>
                let model = HomePageModel()
                model.setValuesForKeys(dict)
                self.dataArray.add(model)
                
            }
            DispatchQueue.main.async(execute: {
                [weak self] in
                self?.collView?.reloadData()
            })
            
        }

    }
}
extension BKHomeViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let coll = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        for oldSubView in coll.contentView.subviews{
            oldSubView.removeFromSuperview()
        }
        let model = self.dataArray[(indexPath as NSIndexPath).item]as! HomePageModel
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        let urlString = URL(string: model.cover_image!)
        imageView.kf.setImage(with:  urlString)
        let label = UILabel(frame: CGRect(x: 0,y: 60,width: 80,height: 20))
        label.text = "\((model.all_comics)!)"
        label.textAlignment = .center
        label.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        imageView.addSubview(label)
        coll.contentView.addSubview(imageView)
        
        
        return coll
    }
    @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let groupListCtrl = GroupListViewController()
        let model = self.dataArray[(indexPath as NSIndexPath).item] as! HomePageModel
        groupListCtrl.id = "\((model.id)!)"
        self.navigationController?.pushViewController(groupListCtrl, animated: true)
        
    }
    
    
    
}



