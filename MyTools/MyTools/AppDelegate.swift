//
//  AppDelegate.swift
//  MyTools
//
//  Created by zhangk on 17/3/23.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
import FBSDKCoreKit
public let kNetworkReachabilityChangedNotification = "kNetworkReachabilityChangedNotification"
@available(iOS 9.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //English is ok 
    //中文也是好的.
    //This is Xcode 8.3.2
    var window: UIWindow?
    var performanceView: GDPerformanceMonitor?
    var parsedUrl:BFURL?
    var refererAppLink = NSDictionary()
//    var service:PPSPingServices?
//    private var reachability:Reachability?
    private var manager:NetworkReachabilityManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        #if DEBUG
            GDPerformanceMonitor.sharedInstance.startMonitoring()
            GDPerformanceMonitor.sharedInstance.configure(configuration: { (textLabel) in
                textLabel?.backgroundColor = .black
                textLabel?.textColor = .white
                textLabel?.layer.borderColor = UIColor.black.cgColor
            })
        #endif
        let hostURL = "www.baidu.com"
//        reachability = Reachability(hostName: hostURL)
//        reachability?.startNotifier()
//        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: NSNotification.Name(rawValue: kNetworkReachabilityChangedNotification), object: nil)
        
        manager = NetworkReachabilityManager(host: hostURL)
        
        manager?.startListening()
        manager?.listener = {
            reach in
            switch reach {
            case .unknown:
                print("AppDelegate:未知的")
            case .notReachable:
                print("AppDelegate:不可用")
            case .reachable(.wwan):
                print("AppDelegate:移动网络")
            case .reachable(.ethernetOrWiFi):
                print("AppDelegate:WiFi")
            }
            NotificationCenter.default.post(name: NSNotification.Name(kNetworkReachabilityChangedNotification), object: reach)
            
        }

        //注册FBSDK
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        Twitter.sharedInstance().start(withConsumerKey: "sKDghGO5klKGC9dgX4CkNM1sK", consumerSecret: "lsXro2RyWrNgje4cG1S3JZ7zCBF73pMJ1wQ6A7SgjMm4gwaZwU")
        
        Share()
        //ppsPing()
        reachaBility()
        window?.rootViewController = MainTabBarViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        print("app open options")
        let urlString = url.description
        let arrayString = urlString.components(separatedBy: "&&")
        if arrayString.count>2{
            if arrayString[0]=="lingyu://twitter" || arrayString[0]=="lingyu://facebook"{
                let nav = window?.rootViewController
                let Type = type(of: nav)
                print(Type)
                if let _ = (nav?.isKind(of: MainTabBarViewController.self)){
                    let tabBar = nav as! MainTabBarViewController
                    let eachVC = tabBar.viewControllers?[tabBar.selectedIndex]
                    if let vc = eachVC{
                        if vc.isKind(of: UINavigationController.self){
                            let navController = vc as! UINavigationController
                            let shareVC = ShareViewController()
                            shareVC.hidesBottomBarWhenPushed = true
                            navController.pushViewController(shareVC, animated: true)
                            return true
                        }
                    }
                    
                }
                if let viewController = nav{
                    viewController.navigationController?.pushViewController(ShareViewController(), animated: true)
                    return true
                }
                if  let _ = (nav?.isKind(of: UINavigationController.self)){
                    
                    //nav?.pushViewController(ShareViewController(), animated: true)
                    return true
                }
                
            }
            return false
        }
        let parsedUrl = BFURL(inboundURL: url, sourceApplication: options[.sourceApplication] as! String)
        self.parsedUrl = BFURL(url: url)
        let appLinkData = parsedUrl?.appLinkData
        if let dict = appLinkData{
            refererAppLink = dict["referer_app_link"] as! NSDictionary
        }
        
        if((parsedUrl?.appLinkData) != nil){
            let targetUrl = parsedUrl?.targetURL
            UIAlertView(title: "Received link", message: targetUrl?.absoluteString, delegate: nil, cancelButtonTitle: "OK").show()
        }
        
        
        
        if (url.description.hasPrefix("fb")){
            let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[.sourceApplication] as! String, annotation: options[.annotation])
            return handled
        }else{
            return Twitter.sharedInstance().application(app, open: url, options: options)
        }
        
    }
    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    
    
//    func reachabilityChanged(n:Notification){
//        if(n.object is Reachability){
//            let reach = n.object as! Reachability
//            updateInterfaceWithReachability(reach: reach)
//        }
//    }
//    func updateInterfaceWithReachability(reach:Reachability){
//        let netStatus = reach.currentReachabilityStatus();
//        switch netStatus {
//        case NotReachable:
//            print("没有网络")
//        case ReachableViaWiFi:
//            print("WiFi")
//        case ReachableViaWWAN:
//            print("WWAN")
//        default:
//            break
//        }
//    }

//    deinit {
//        reachability?.stopNotifier()
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: kNetworkReachabilityChangedNotification), object: nil)
//    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    private func Share(){
        ShareSDK.registerActivePlatforms(
            [
                SSDKPlatformType.typeFacebook.rawValue,
                SSDKPlatformType.typeTwitter.rawValue,
                SSDKPlatformType.typeYouTube.rawValue,
                SSDKPlatformType.typeCopy.rawValue,
                SSDKPlatformType.typeGooglePlus.rawValue,
                SSDKPlatformType.typeFacebookMessenger.rawValue,
            ],
            onImport: {(platform : SSDKPlatformType) -> Void in
                switch platform
                {
                case SSDKPlatformType.typeFacebook:
                    ShareSDKConnector.connectFacebookMessenger(FacebookConnector.classForCoder())
                case SSDKPlatformType.typeFacebookMessenger:
                    ShareSDKConnector.connectFacebookMessenger(FBSDKMessengerSharer.classForCoder())
                case SSDKPlatformType.typeTwitter:
                    break
                case SSDKPlatformType.typeYouTube:
                    break
                default:
                    break
                }
        },
            onConfiguration: {(platform : SSDKPlatformType , appInfo : NSMutableDictionary?) -> Void in
                switch platform
                {
                case SSDKPlatformType.typeFacebook:
                    
                    appInfo?.ssdkSetupFacebook(byApiKey: "149256552318401", appSecret: "458f503ccee25ad1c01b0c2923e3da6c", displayName: "ShareSDK", authType: SSDKAuthTypeBoth)
                    
//                case SSDKPlatformType.typeTwitter:
//                    appInfo?.ssdkSetupTwitter(byConsumerKey: "sKDghGO5klKGC9dgX4CkNM1sK", consumerSecret: "lsXro2RyWrNgje4cG1S3JZ7zCBF73pMJ1wQ6A7SgjMm4gwaZwU", redirectUri: "https://www.uilucky.com")
                    
                case SSDKPlatformType.typeYouTube:
                    appInfo?.ssdkSetupYouTube(byClientId: "528737955579-t3m711acpu2mrk28sfgki2g4acdqt0c8.apps.googleusercontent.com", clientSecret: "", redirectUri: "http://localhost")
                default:
                    break
                }
        })
    }
    
    func ppsPing(){
        /*
        service = PPSPingServices.service(withAddress: "www.uilucky.com")
        service?.start(callbackHandler: { (summary, dic) in
            if let sum = summary{
                switch sum.status{
                case PPSPingStatusDidStart:
                    print("Start")
                case PPSPingStatusDidFailToSendPacket:
                    print("SendPacket")
                case PPSPingStatusDidReceivePacket:
                    print("ReceivePacket")
                case PPSPingStatusDidReceiveUnexpectedPacket:
                    print("ReceiveUnexpectedPacket")
                case PPSPingStatusDidTimeout:
                    print("Timeout")
                case PPSPingStatusError:
                    print("Error")
                case PPSPingStatusFinished:
                    print("Finished")
                default:
                    break
                }
                print(sum.rtt)
                print(sum.host)
                
                
            }
            
            
        })*/
    }
    func reachaBility(){
        let reachaBility = Reachability(hostName: "https://www.baidu.com")
        if (reachaBility?.startNotifier())==true{
            print("通")
        }else{
            print("不通")
        }
    }

}

