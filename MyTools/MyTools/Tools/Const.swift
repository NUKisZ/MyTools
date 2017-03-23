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

//private let infoDic = Bundle.main.infoDictionary
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



//ip 为测试服务器
//public let MWSIp = "http://192.168.0.112"
//public let MWSIp = "http://192.168.0.16"
public let MWSIp = "https://www.mengwushe.com"
public let MWSip = "http://www.mengwushe.com"
public var userID = "0"
public let MWSTestAccount = MWSIp + "/index.php/Weixin/Mobile/apprelog"
public let MWSHomeUrlString = MWSIp+"/index.php/Weixin/Index/index/userid/%@/isWX/0"

//http://192.168.0.16/index.php/Weixin/Goods/allgoodswthtype/userid/0/isWX/0
public let MWSAllCommodityUrlString = MWSIp+"/index.php/Weixin/Goods/allgoods/userid/%@/isWX/0"
//public let MWSAllCommodityUrlString = MWSIp+"/index.php/Weixin/Goods/allgoodswthtype/userid/%@/isWX/0"
public let MWSMessagesUrlString = MWSIp+"/index.php/Weixin/Messages/messages/isWX/0/userid/%@"
public let MWSShoppingcarUrlString = MWSIp+"/index.php/Weixin/Shoppingcar/shoppingcar/isWX/0/userid/%@"
public let MWSMineUrlString = MWSIp+"/index.php/Weixin/User/index/userid/%@/isWX/0"
public let MWSLoginUrlString = MWSIp+"/index.php?m=Admin&a=login"
public let MWSSearchUrlString = MWSIp+"/index.php/Weixin/Search/search/isWX/0"
public let MWSSearchUrlStringInfo = MWSIp+"/index.php/Weixin/Search/search_result/userid/%@/isWX/0/searchval/%@"
public let MWSGamerecordUrlString = MWSIp+"/index.php/Weixin/Shoppingcar/gamerecord/isWX/0/userid/%@"
//分享图片
public let MWSShareImageUrl = "http://ww4.sinaimg.cn/mw690/ada5953fgw1f9zqjqyhd9j2050050wec.jpg"


//找回密码时获取验证码
public let MWSGetMyCodeUrlString = MWSIp+"/index.php/Weixin/Phone/getmycode"
//注册时获取验证码
public let MWSGetCodeUrlString = MWSIp+"/index.php/Weixin/Phone/getcode"
//注册
public let MWSRequestUrlString = MWSIp+"/index.php/Weixin/Mobile/mobileRegister"
//登陆
public let MWSNameLoginUrlString = MWSIp+"/index.php/Weixin/Mobile/applogin"

//手机号注册
public let MWSMobileRequestUrlString = MWSIp+"/index.php/Weixin/Mobile/mobileRegister"
//重置密码
public let MWSResetPasswordUrlStirng = MWSIp+"/index.php/Weixin/Mobile/repass"



//用户注册
public let MWSUserRegistered = MWSIp+"/index.php/Weixin/Mobile/appregister"





