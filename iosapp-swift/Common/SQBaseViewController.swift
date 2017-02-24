//
//  SQBaseViewController.swift
//  iosapp-swift
//
//  Created by ysq on 2017/2/16.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit


class SQBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(SQBaseViewController.successRequest(noti:)), name: NSNotification.Name(rawValue: request_notification), object: nil)
        // Do any additional setup after loading the view.
    }
    
    
    func loadData() {
        print("super load request")
        guard SQNetworkManager.shared.isAccessNetwork()! else {
            self.view.addSubview(noNetworkAlert)
            return
        }
    }
    
    func successRequest(noti: NSNotification) {
        let result = noti.userInfo?["result"]
        print(result as! String)
    }
    
    lazy var noNetworkAlert: UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height))
        label.text = "请检查网络!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.orange
        label.isUserInteractionEnabled = true
        let tag = UITapGestureRecognizer.init(target: self, action: #selector(test))
        label.addGestureRecognizer(tag)
        return label
    }()
    
    func test() {
        print("test")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
