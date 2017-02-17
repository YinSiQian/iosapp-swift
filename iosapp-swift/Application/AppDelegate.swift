//
//  AppDelegate.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/16.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = SQRootViewController()
        window?.makeKeyAndVisible()

        //https://www.oschina.net/action/oauth2/authorize?response_type=code&client_id=CTTTL5ff4mOLA8ed7sCi&redirect_uri=http://baidu.com
        
        //https://www.oschina.net//action/openapi/token?client_id=CTTTL5ff4mOLA8ed7sCi&client_secret=mcoHHVkSINCuQFaz1RnVJ1bQ2zdLIjIzgrant_type=authorization_code&redirect_uri=http://baidu.com
        //code=ZTiEBc
        
        //https://www.oschina.net/action/openapi/token?client_id=CTTTL5ff4mOLA8ed7sCi&client_secret=mcoHHVkSINCuQFaz1RnVJ1bQ2zdLIjIz&grant_type=authorization_code&redirect_uri=http://baidu.com&code=ZTiEBc&dataType=json
        
        //{"access_token":"769bc2f0-ada7-42e6-8d34-036273ad57a7","refresh_token":"2829da4a-5aad-4da0-b682-c063de8caecb","uid":2475593,"token_type":"bearer","expires_in":604799}
        
//        SQNetworkManager.shared.getRequest(urlString: "https://www.oschina.net/action/openapi/news_list?access_token=769bc2f0-ada7-42e6-8d34-036273ad57a7&catalog=2&page=1&pageSize=20&dataType=json", parameters: nil) { (success, json, error) in
//            
//        }
        
        /*****************控件外观设置*************/
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().barTintColor = UIColor.init(hex6: 0x24CF5F)
        
        return true
    }

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

