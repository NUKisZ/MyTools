//
//  AppDelegate.swift
//  MyTools
//
//  Created by zhangk on 17/3/23.
//  Copyright © 2017年 zhangk. All rights reserved.
//

import UIKit
public let kNetworkReachabilityChangedNotification = "kNetworkReachabilityChangedNotification"
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var performanceView: GDPerformanceMonitor?
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

        window?.rootViewController = MainTabBarViewController()
        window?.makeKeyAndVisible()
        return true
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


}

