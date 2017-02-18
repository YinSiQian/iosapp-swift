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

        
        // Do any additional setup after loading the view.
    }
    
    
    func loadData() {
        guard SQNetworkManager.shared.isAccessNetwork()! else {
            self.view.addSubview(noNetworkAlert)
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let noNetworkAlert: UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height))
        label.text = "请检查网络"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.orange
        return label
    }()

}
