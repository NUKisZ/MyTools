//
//  PhotoLibraryDidChangeViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/5/25.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
import Photos
class PhotoLibraryDidChangeViewController: BaseViewController {

    //取得的资源结果，用来存放的PHAsset
    var assetsFetchResults:PHFetchResult<PHAsset>!
    //带缓存的图片管理对象
    var imageManager:PHCachingImageManager!
    //用于显示缩略图
    var imageView:UIImageView!
    //缩略图大小
    var assetGridThumbnailSize:CGSize!
    var textView:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        textView = UITextView(frame: CGRect(x: 0, y: 64, w: kScreenWidth, h: 100))
        textView.text = ""
        textView.textColor = UIColor.black
        view.addSubview(textView)
        imageView = UIImageView()
        imageView.frame = CGRect(x: 100, y: 300, w: 150, h: 150)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        imageManager = PHCachingImageManager()
        let scale = UIScreen.main.scale
        assetGridThumbnailSize = CGSize(width: imageView.frame.width*scale, height: imageView.frame.height*scale)
        //申请权限
        PHPhotoLibrary.requestAuthorization {
            [weak self]
            (status) in
            if(status != .authorized){
                return
            }
            //启动后先获取目前所有照片资源
            let allPhotosOptions = PHFetchOptions()
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            self?.assetsFetchResults = PHAsset.fetchAssets(with: .image, options: allPhotosOptions)
            DispatchQueue.main.async {
                self?.textView.text = "资源获取完毕\n"
            }
            print("资源获取完毕-----")
            //监听资源改变
            PHPhotoLibrary.shared().register(self!)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//MARK:PHPhotoLibraryChangeObserver代理实现，图片新增、删除、修改开始后会触发
extension PhotoLibraryDidChangeViewController : PHPhotoLibraryChangeObserver{
    //当照片库发生变化的时候会触发
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        //获取assetsFetchResults的所有变化情况，以及assetsFetchResults的成员变化前后的数据
        guard let collectionChanges = changeInstance.changeDetails(for: self.assetsFetchResults as! PHFetchResult<PHObject>) else {
            return
        }
        DispatchQueue.main.async {
            [weak self] in
            //获取最新的完整数据
            if let allResult = collectionChanges.fetchResultAfterChanges as? PHFetchResult<PHAsset>{
                self?.assetsFetchResults = allResult
            }
            if !collectionChanges.hasIncrementalChanges || collectionChanges.hasMoves{
                return
            }else{
                self?.textView.text = (self?.textView.text)!+"监听到变化\n"
                print("监听到变化")
                if let removedIndexes = collectionChanges.removedIndexes,removedIndexes.count>0{
                    self?.textView.text = (self?.textView.text)!+"删除了\(removedIndexes.count)张照片\n"
                    print("删除了\(removedIndexes.count)张照片")
                }
                if let changedIndexes = collectionChanges.changedIndexes,changedIndexes.count>0{
                    self?.textView.text = (self?.textView.text)!+"修改了\(changedIndexes.count)张照片\n"
                    print("修改了\(changedIndexes.count)张照片")
                }
                if let insertedIndexes = collectionChanges.insertedIndexes,insertedIndexes.count>0{
                    self?.textView.text = (self?.textView.text)!+"新增了\(insertedIndexes.count)张照片\n"
                    self?.textView.text = (self?.textView.text)!+"将最新的一张照片显示\n"
                    print("新增了\(insertedIndexes.count)张照片")
                    print("将最新的一张照片显示")
                    //获取最后添加的图片资源
                    let asset = self?.assetsFetchResults[insertedIndexes.first!]
                    //获取缩略图
                    self?.imageManager.requestImage(for: asset!, targetSize: (self?.assetGridThumbnailSize)!, contentMode: .aspectFit, options: nil, resultHandler: { (image, info) in
                        self?.imageView.image = image
                    })
                }
                
            }
            
        }
    }
}
