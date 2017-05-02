//
//  DetailViewController.swift
//  NUK
//
//  Created by NUK on 16/8/13.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,ZKDownloaderDelegate {

    @IBOutlet weak var appImageView: UIImageView!
 


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starView: StarView!
    @IBOutlet weak var detailLabel: UILabel!
    var id:String!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.downloadData()
    }
    
    func downloadData(){
        let urlString = String(format: "http://picaman.picacomic.com/api/comics/%@", self.id)
        let downloader = ZKDownloader()
        downloader.getWithUrl(urlString)
        downloader.delegate = self
    }
    
    func showDetail(_ model:DetailModel){
        let urlString = URL(string: model.cover_image!)
        
        self.appImageView.kf.setImage(with: urlString)
        self.nameLabel.text = model.name!
        self.starView.setRating(CGFloat(model.rank!))
        self.detailLabel.text = model.myDescription!
        let btnW:CGFloat = 80
        let btnH:CGFloat = 30
        let spaceX:CGFloat = (kScreenWidth - btnW*3)/4.0
        let spaceY:CGFloat = 30
        let space:CGFloat = 320
        for i in 0..<Int(model.ep_count!){
            let row = i / 3
            let col = i % 3
            
            let frame = CGRect(x: spaceX + (spaceX + btnW) * CGFloat(col), y: space + spaceY + (spaceY + btnH) * CGFloat(row), width: btnW, height: btnH)
            let btn = DetailButton(frame: frame)
            btn.ep_count = model.ep_count
            btn.tag = 500+i
            btn.addTarget(self, action: #selector(gotoPaPaPa(_:)), for: .touchUpInside)
            self.view.addSubview(btn)
        }
    }
    func gotoPaPaPa(_ btn:DetailButton){
        
        
        let papapaCtrl = PapapaViewController()
        if let count = btn.ep_count{
            papapaCtrl.ep_count = "\(count)"
        
        }
        papapaCtrl.id = self.id
        self.navigationController?.pushViewController(papapaCtrl, animated: true)
        
        
        
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
extension DetailViewController{
    func downloader(_ download: ZKDownloader, didFinishWithData data: Data?) {
        let jsonData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        if (jsonData as AnyObject).isKind(of: NSDictionary.self){
            let jsonDict = jsonData as! NSDictionary
            let comicDict = jsonDict["comic"] as! Dictionary<String,AnyObject>
            let model = DetailModel()
            model.setValuesForKeys(comicDict)
            model.ep_count = jsonDict["ep_count"] as? NSNumber
            DispatchQueue.main.async {
                self.showDetail(model)
            }
        }
    }
    func downloader(_ downloader: ZKDownloader, didFailWithError error: NSError) {
        ZKTools.showAlert(error.localizedDescription, onViewController: self)
    }
}



