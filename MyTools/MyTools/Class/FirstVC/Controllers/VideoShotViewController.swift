//
//  VideoShotViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/5/25.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class VideoShotViewController: BaseViewController {

    var imageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(frame: CGRect(x: 0, y: 64, width: 150, height: 150))
        view.addSubview(imageView)
        //异步获取网络视频
        DispatchQueue.global(qos: .default).async {
            [weak self] in
            //获取网络视频
            let url = "http://baobab.wdjcdn.com/1457546796853_5976_854x480.mp4"
            let videoURL = URL(string: url)!
            let avAsset = AVAsset(url: videoURL)
            
            //生成视频截图
            let generator = AVAssetImageGenerator(asset: avAsset)
            generator.appliesPreferredTrackTransform = true
            let time = CMTimeMakeWithSeconds(0.0,600)
            var actualTime:CMTime = CMTimeMake(0,0)
            let imageRef:CGImage = try! generator.copyCGImage(at: time, actualTime: &actualTime)
            let frameImg = UIImage(cgImage: imageRef)
            
            //在主线程中显示截图
            DispatchQueue.main.async(execute: {
                self?.imageView.image = frameImg
            })
        }
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
