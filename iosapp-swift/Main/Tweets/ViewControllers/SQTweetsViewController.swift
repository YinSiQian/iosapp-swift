//
//  SQTweetsViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/16.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class SQTweetsViewController: UIViewController {

    
    lazy var testLabl: UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height))
        label.text = "请检查网络"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.orange
        label.isUserInteractionEnabled = true
        let tag = UITapGestureRecognizer.init(target: self, action: #selector(tweet))
        label.addGestureRecognizer(tag)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let arr = ["http://pic.qyer.com/public/mobileapp/homebanner/2016/07/14/14684754751851/w800",
                   "http://pic.qyer.com/public/mobileapp/homebanner/2016/07/14/14684771601902/w800",
                   "http://pic.qyer.com/public/mobileapp/homebanner/2016/07/14/14684772389521/w800",
                   "http://pic.qyer.com/public/mobileapp/homebanner/2016/07/18/14688064503265/w800"
        ];
        // Do any additional setup after loading the view.
        let cycle = SQCycleScrollView.init(frame: CGRect.init(x: 0, y: 100, width: screen_width, height: 120))
        cycle.image_urls = arr
        cycle.autoTime = 3
        view.addSubview(cycle)
    }
    
    func tweet() {
        print("this is tweet")
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
