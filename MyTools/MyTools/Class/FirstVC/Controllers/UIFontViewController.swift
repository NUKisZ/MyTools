//
//  UIFontViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/5/11.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class UIFontViewController: TableViewBaseController {
    lazy var seDataArray = NSMutableArray()
    lazy var plDataArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        automaticallyAdjustsScrollViewInsets = false
        createTableView(frame: CGRect(x: 0, y: 64, w: kScreenWidth, h: kScreenHeight-64), style: .grouped, separatorStyle: .none)
        for name in UIFont.familyNames{
            seDataArray.add(name)
            let array = NSMutableArray()
            for font in UIFont.fontNames(forFamilyName: name){
                array.add(font)
            }
            plDataArray.add(array)
            
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
extension UIFontViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return seDataArray.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (plDataArray[section] as! NSMutableArray).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "UIFontViewController"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: id)
        if (cell == nil){
            cell = UITableViewCell(style: .default, reuseIdentifier: id)
        }
        let font = (plDataArray[indexPath.section] as! NSMutableArray)[indexPath.row] as! String
        cell?.textLabel?.font = UIFont(name: font, size: 14)
        cell?.textLabel?.text = "疯狂让利神秘开启"+font
        return cell!
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return seDataArray[section] as? String
    }
    
}
