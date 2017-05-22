//
//  EFQRCodeViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/5/19.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class EFQRCodeViewController: BaseViewController , UITableViewDelegate, UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor(red: 97.0 / 255.0, green: 207.0 / 255.0, blue: 199.0 / 255.0, alpha: 1)
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupViews() {
        let screenSize = UIScreen.main.bounds.size
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 48)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.text = "EFQRCode\(version == "" ? "" : "\n\(version)")"
        titleLabel.numberOfLines = 0
        self.view.addSubview(titleLabel)
        titleLabel.frame = CGRect(
            x: 0, y: 0, width: screenSize.width, height: screenSize.height / 2.5
        )
        
        let tableView = UITableView()
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = true
        #if os(iOS)
            tableView.separatorColor = UIColor.white
        #endif
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        self.view.addSubview(tableView)
        tableView.frame = CGRect(
            x: 0, y: titleLabel.frame.maxY, width: screenSize.width, height: screenSize.height / 3.0
        )
        
        let bottomLabel = UIButton(type: .system)
        bottomLabel.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        bottomLabel.setTitleColor(UIColor.white, for: .normal)
        bottomLabel.setTitle("https://github.com/EyreFree/EFQRCode", for: .normal)
        #if os(iOS)
            bottomLabel.addTarget(self, action: #selector(EFQRCodeViewController.openBlog), for: .touchDown)
        #endif
        self.view.addSubview(bottomLabel)
        bottomLabel.frame = CGRect(
            x: 0, y: screenSize.height - 40, width: screenSize.width, height: 20
        )
    }
    
    func openBlog() {
        if let tryUrl = URL(string: "https://github.com/EyreFree/EFQRCode") {
            UIApplication.shared.openURL(tryUrl)
        }
    }
    
    // UITableViewDelegate & UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        #if os(iOS)
            switch indexPath.row {
            case 0:
                hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(RecognizerController(), animated: true)
                break
            default:
                hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(GeneratorController(), animated: true)
                break
            }
        #else
            self.navigationController?.pushViewController(GeneratorController(), animated: true)
        #endif
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        #if os(iOS)
            return 2
        #else
            return 1
        #endif
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        #if os(iOS)
            let text = ["Recognizer", "Generator"][indexPath.row]
        #else
            let text = "Generator"
        #endif
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = text
        let backView = UIView()
        backView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.64)
        cell.selectedBackgroundView = backView
        let imageView = UIImageView(image: UIImage(named: text))
        imageView.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        imageView.contentMode = .scaleAspectFit
        cell.accessoryView = imageView
        return cell
    }
}
