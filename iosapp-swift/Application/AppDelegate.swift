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

    lazy var launchImage: UIImageView? = {
        let imageView = UIImageView.init(frame: UIScreen.main.bounds)
        return imageView
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = SQRootViewController()
        window?.makeKeyAndVisible()

//        loadADImage()
//        showLaunchImage()
        /*****************控件外观设置*************/
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().barTintColor = UIColor.init(hex6: 0x24CF5F)
        
        return true
    }
    
    func loadADImage() {
        let startView = AdverticeImage.init(frame: UIScreen.main.bounds)

        if (UserDefaults.standard.object(forKey: ads_image) != nil) {
            let image = UserDefaults.standard.object(forKey: ads_image) as! UIImage
            startView.imageView.image = image
            self.window?.addSubview(startView)
            self.launchImage?.removeFromSuperview()
            self.launchImage = nil
            startView.coundown()
        } else {
            SQNetworkManager.shared.getRequest(urlString: start_page, parameters: nil) { (success, json, error) in
                let imageURL = json?["data"]["photo"]
                //print((imageURL?.string)! as String)
                startView.imageView.kf.setImage(with: (imageURL?.string)!.url(), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, type, url) in
                    UserDefaults.standard.set(image, forKey: ads_image)
                    self.window?.addSubview(startView)
                    self.launchImage?.removeFromSuperview()
                    self.launchImage = nil
                    startView.coundown()
                })
            }
        }
    }
    
    
    
    func showLaunchImage() {
        let viewSize = self.window?.bounds.size
        let viewPrientation = "Portrait"
        var launchName: String?
        let imagasDict: NSArray = Bundle.main.infoDictionary?["UILaunchImages"] as! NSArray
        for dict in imagasDict {
            let infoDict = dict as! NSDictionary
            let imageSize = CGSizeFromString(infoDict["UILaunchImageSize"] as! String)
            let launchImageOrientation = infoDict["UILaunchImageOrientation"] as! String
            if __CGSizeEqualToSize(imageSize, viewSize!) && viewPrientation == launchImageOrientation {
                launchName = infoDict["UILaunchImageName"] as? String
            }
        }
        launchImage?.image = UIImage.init(named: launchName!)
        launchImage?.contentMode = .scaleAspectFill
        window?.addSubview(launchImage!)
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

