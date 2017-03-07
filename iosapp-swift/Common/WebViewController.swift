//
//  WebViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/3/7.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
        // Do any additional setup after loading the view.
        let cycleView = SQCycleScrollView.init(frame: CGRect(x: 0, y: 100, width: screen_width, height: 200))
        
        cycleView.image_urls = [
            "http://pic.qyer.com/public/mobileapp/homebanner/2017/03/03/14885105563634/w800",
            "http://pic.qyer.com/ra/img/14881833897056",
            "http://pic.qyer.com/public/mobileapp/homebanner/2017/03/03/14885109302137/w800",
            "http://pic.qyer.com/public/mobileapp/homebanner/2017/03/07/14888517745290/w800",
            "http://pic.qyer.com/public/mobileapp/homebanner/2017/03/07/14888517956193/w800"
        ]
        cycleView.autoTime = 3.0
        view.addSubview(cycleView)
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
