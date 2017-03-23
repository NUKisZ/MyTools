//
//  Const.swift
//  MengWuShe
//
//  Created by zhangk on 16/10/17.
//  Copyright © 2016年 zhangk. All rights reserved.
//

import UIKit

public let kScreenWidth = UIScreen.main.bounds.size.width                       //屏幕宽度
public let kScreenHeight = UIScreen.main.bounds.size.height                     //屏幕高度
public let kDeviceName = UIDevice.current.name                                   //获取设备名称 例如：**的手机
public let kSysName = UIDevice.current.systemName                                //获取系统名称 例如：iPhone OS
public let kSysVersion = UIDevice.current.systemVersion                          //获取系统版本 例如：9.2
public let kDeviceUUID = (UIDevice.current.identifierForVendor?.uuidString)!     //获取设备唯一标识符 例如：FBF2306E-A0D8-4F4B-BDED-9333B627D3E6
public let kDeviceModel = UIDevice.current.model                                 //获取设备的型号 例如：iPhone

public let kInfoDic = Bundle.main.infoDictionary! as [String:Any]
public let kAppVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"])! // 获取App的版本
public let kAppBuildVersion = (Bundle.main.infoDictionary?["CFBundleVersion"])!       // 获取App的build版本
public let kAppName = (Bundle.main.infoDictionary?["CFBundleDisplayName"])!           // 获取App的名称



//var context = JSContext()
//context = web?.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext?
public let javaScriptContext = "documentView.webView.mainFrame.javaScriptContext"


//微信相关
//获得access_token
public let MWSGetAccessToken = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code"
//测试access_token是否有效
public let MWSTestAccessToken = "https://api.weixin.qq.com/sns/auth?access_token=%@&openid=%@"

//获得用户信息
public let MWSGetUserInfo = "https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@"







