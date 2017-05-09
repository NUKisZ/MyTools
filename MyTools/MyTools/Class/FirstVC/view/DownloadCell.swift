//
//  DownloadCell.swift
//  MyTools
//
//  Created by gongrong on 2017/4/24.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit

class DownloadCell: UITableViewCell {
    var labelName:UILabel = UILabel()
    var labelSize:UILabel = UILabel()
    var labelProgress:UILabel = UILabel()
    var downloadTask:DownloadTask?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(labelName)
        contentView.addSubview(labelSize)
        contentView.addSubview(labelProgress)
        labelName.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.top.equalTo(contentView.snp.top).offset(10)
        }
        labelSize.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(50)
            make.top.equalTo(labelName.snp.bottom).offset(5)
        }
        labelProgress.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.top.equalTo(contentView.snp.top).offset(10)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(updateprogress(notification:)), name: NSNotification.Name(rawValue: DownloadTaskNotification.Progress.rawValue), object: nil)
    }
    func updateprogress(notification:Notification){
        guard let info = notification.object as? NSDictionary else { return }
        
        if let taskIdentifier = info["taskIdentifier"] as? NSNumber {
            
            if taskIdentifier.intValue == self.downloadTask?.taskIdentifier {
                
                guard let written = info["totalBytesWritten"] as? NSNumber else { return }
                guard let total = info["totalBytesExpectedToWrite"] as? NSNumber else { return }
                
                let formattedWrittenSize = ByteCountFormatter.string(fromByteCount: written.int64Value, countStyle: ByteCountFormatter.CountStyle.file)
                let formattedTotalSize = ByteCountFormatter.string(fromByteCount: total.int64Value, countStyle: ByteCountFormatter.CountStyle.file)
                
                self.labelSize.text = "\(formattedWrittenSize) / \(formattedTotalSize)"
                let percentage = Int((written.doubleValue / total.doubleValue) * 100.0)
                self.labelProgress.text = "\(percentage)%"
                
            }
            
        }
    }
    
    func updateData(task:DownloadTask){
        self.downloadTask = task
        labelName.text = self.downloadTask?.url.lastPathComponent
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
