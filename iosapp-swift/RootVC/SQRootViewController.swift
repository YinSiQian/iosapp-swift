//
//  SQRootViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/16.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class SQRootViewController: UITabBarController {

    
    var centerButton: UIButton! 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        customize(tabBar: self)
        // Do any additional setup after loading the view.
    }
    
    func setupViewControllers() {
        let newsVC = SQNewsViewController()
        newsVC.title = "综合"
        
        let tweetsVC = SQTweetsViewController()
        tweetsVC.title = "动弹"
        
        let discoverVC = SQDiscoverViewController()
        discoverVC.title = "发现"
        
        let mineVC = SQMineViewController()
        mineVC.title = "我的"
        
        self.viewControllers = [
            setNav(viewController: newsVC),
            setNav(viewController: tweetsVC),
            UIViewController(),
            setNav(viewController: discoverVC),
            setNav(viewController: mineVC)
        ]
    }
    
    func customize(tabBar: UITabBarController) {
        let titles = ["综合","动弹","","发现","我的"]
        let images = [
            "tabbar-news",
            "tabbar-tweet",
            "",
            "tabbar-discover",
            "tabbar-me"
        ]
        var index = 0
        for item in self.tabBar.items! {
            item.title = titles[index]
            let selectedImage = images[index] + "-selected"
            item.selectedImage = UIImage.init(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
            item.image = UIImage.init(named: images[index])?.withRenderingMode(.alwaysOriginal)
            item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(hex6:0x24CF5F, alpha: 1)], for: .selected)
            index += 1
        }
        self.tabBar.items?[2].isEnabled = false
        addCenterButton(image: UIImage.init(named: "ic_nav_add")!)
    }
    
    func addCenterButton(image: UIImage) {
        centerButton = UIButton.init(type: .custom)
        let origin = self.view.convert(tabBar.center, to: tabBar)
        let buttonSize = CGSize.init(width: tabBar.frame.size.width / 5 - 6, height: tabBar.frame.size.height - 4)
        centerButton.frame = CGRect.init(x: origin.x - buttonSize.width / 2, y: origin.y - buttonSize.height / 2, width: buttonSize.width, height: buttonSize.height)
        centerButton.setImage(image, for: .normal)
        centerButton.setImage(UIImage.init(named: "ic_nav_add_actived"), for: .selected)
        centerButton.addTarget(self, action: #selector(SQRootViewController.buttonPressed), for: .touchUpInside)
        tabBar.addSubview(centerButton)
    }
    
    func buttonPressed() {
        print("button pressed")
    }
    
    
    func setNav(viewController: UIViewController) -> SQNavigationController {
        let nav = SQNavigationController.init(rootViewController: viewController)
        return nav
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
