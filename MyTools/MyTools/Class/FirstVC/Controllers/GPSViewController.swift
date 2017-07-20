//
//  GPSViewController.swift
//  MyTools
//
//  Created by gongrong on 2017/7/20.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
import CoreLocation
class GPSViewController: BaseViewController {

    //定位管理器
    let locationManager:CLLocationManager = CLLocationManager()
    var longitudeLabel:UILabel!//经度
    var latitudeLabel:UILabel!//纬度
    var heightLabel:UILabel!//高度,海拔
    var horizontalLabel:UILabel!//水平精度
    var verticalLabel:UILabel!//垂直精度
    var courseLabel:UILabel!//获取方向
    var speedLabel:UILabel!//速度
    var locationLabel:UILabel!//位置
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        setupView()
        //设置定位服务管理器代理
        locationManager.delegate = self
        //设置定位进度
        /*
        kCLLocationAccuracyBestForNavigation ：精度最高，一般用于导航
        kCLLocationAccuracyBest ： 精确度最佳
        kCLLocationAccuracyNearestTenMeters ：精确度10m以内
        kCLLocationAccuracyHundredMeters ：精确度100m以内
        kCLLocationAccuracyKilometer ：精确度1000m以内
        kCLLocationAccuracyThreeKilometers ：精确度3000m以内
         */
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        locationManager.distanceFilter = 100
        ////发送授权申请
        locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled())
        {
            //允许使用定位服务的话，开启定位服务更新
            locationManager.startUpdatingLocation()
            print("定位开始")
        }
    }
    
    private func initView(){
        let width = kScreenWidth-20
        longitudeLabel=UILabel()
        longitudeLabel.preferredMaxLayoutWidth = width
        latitudeLabel=UILabel()
        latitudeLabel.preferredMaxLayoutWidth = width
        heightLabel=UILabel()
        heightLabel.preferredMaxLayoutWidth = width
        horizontalLabel=UILabel()
        horizontalLabel.preferredMaxLayoutWidth = width
        verticalLabel=UILabel()
        verticalLabel.preferredMaxLayoutWidth = width
        courseLabel=UILabel()
        courseLabel.preferredMaxLayoutWidth = width
        speedLabel=UILabel()
        speedLabel.preferredMaxLayoutWidth = width
        locationLabel=UILabel()
        locationLabel.numberOfLines = 0
        locationLabel.preferredMaxLayoutWidth = width
        view.addSubview(longitudeLabel)
        view.addSubview(latitudeLabel)
        view.addSubview(heightLabel)
        view.addSubview(horizontalLabel)
        view.addSubview(verticalLabel)
        view.addSubview(courseLabel)
        view.addSubview(speedLabel)
        view.addSubview(locationLabel)
        
    }
    private func setupView(){
        longitudeLabel.snp.makeConstraints {
            [weak self]
            (make) in
            make.left.equalTo((self?.view.snp.left)!).offset(20)
            make.top.equalTo((self?.view.snp.top)!).offset(70)
        }
        latitudeLabel.snp.makeConstraints {
            [weak self]
            (make) in
            make.left.equalTo((self?.longitudeLabel.snp.left)!)
            make.top.equalTo((self?.longitudeLabel.snp.bottom)!).offset(20)
        }
        heightLabel.snp.makeConstraints {
            [weak self]
            (make) in
            make.left.equalTo((self?.longitudeLabel.snp.left)!)
            make.top.equalTo((self?.latitudeLabel.snp.bottom)!).offset(20)
        }
        horizontalLabel.snp.makeConstraints {
            [weak self]
            (make) in
            make.left.equalTo((self?.longitudeLabel.snp.left)!)
            make.top.equalTo((self?.heightLabel.snp.bottom)!).offset(20)
        }
        verticalLabel.snp.makeConstraints {
            [weak self]
            (make) in
            make.left.equalTo((self?.longitudeLabel.snp.left)!)
            make.top.equalTo((self?.horizontalLabel.snp.bottom)!).offset(20)
        }
        courseLabel.snp.makeConstraints {
            [weak self]
            (make) in
            make.left.equalTo((self?.longitudeLabel.snp.left)!)
            make.top.equalTo((self?.verticalLabel.snp.bottom)!).offset(20)
        }
        speedLabel.snp.makeConstraints {
            [weak self]
            (make) in
            make.left.equalTo((self?.longitudeLabel.snp.left)!)
            make.top.equalTo((self?.courseLabel.snp.bottom)!).offset(20)
        }
        locationLabel.snp.makeConstraints {
            [weak self]
            (make) in
            make.left.equalTo((self?.longitudeLabel.snp.left)!)
            make.top.equalTo((self?.speedLabel.snp.bottom)!).offset(20)
            
            
        }
    }
    

    //将经纬度解析成字符串
    func reverseActon(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        //位置
        let  geoCoder = CLGeocoder()
        let loc = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(loc) {
            [weak self]
            (pls: [CLPlacemark]?, error: Error?)  in
            if error == nil {
                guard pls != nil else {return}
                if let place = pls?.first{
                    print(place.subLocality!)//定位到的区
                    var country = ""
                    if place.country != nil{
                        country = place.country!
                    }
                    
                    var administrativeArea = ""
                    if place.administrativeArea != nil {
                        administrativeArea = place.administrativeArea!
                    }
                    
                    var locality = ""
                    if place.locality != nil {
                        locality = place.locality!
                    }
                    var subLocality = ""
                    if place.subLocality != nil{
                        subLocality = place.subLocality!
                    }
                    var thoroughfare = ""
                    if place.thoroughfare != nil{
                        thoroughfare = place.thoroughfare!
                    }
                    var subThoroughfare = ""
                    if place.subThoroughfare != nil{
                        subThoroughfare = place.subThoroughfare!
                    }
                    DispatchQueue.main.async {
                        self?.locationLabel.text =  "您的位置:" + country + administrativeArea + locality + subLocality + thoroughfare + subThoroughfare
                    }
                    
                }
            }else {
                print("错误")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
extension GPSViewController:CLLocationManagerDelegate{
    //定位改变执行，可以得到新位置、旧位置
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //获取最新的坐标
        let currLocation:CLLocation = locations.last!
        longitudeLabel.text = "经度：\(currLocation.coordinate.longitude)"
        //获取纬度
        latitudeLabel.text = "纬度：\(currLocation.coordinate.latitude)"
        //获取海拔
        heightLabel.text = "海拔：\(currLocation.altitude)"
        //获取水平精度
        horizontalLabel.text = "水平精度：\(currLocation.horizontalAccuracy)"
        //获取垂直精度
        verticalLabel.text = "垂直精度：\(currLocation.verticalAccuracy)"
        //获取方向
        courseLabel.text = "方向：\(currLocation.course)"
        //获取速度
        speedLabel.text = "速度：\(currLocation.speed)"
        self.reverseActon(latitude: currLocation.coordinate.latitude, longitude: currLocation.coordinate.longitude)
    }
}
