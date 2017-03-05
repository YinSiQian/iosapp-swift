//
//  BBSLayoutViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/3/3.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class BBSLayoutViewController: SQBaseViewController {

    lazy var modelArr = [BBSModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        loadData()
      
    }

    
    override func loadData() {
        super.loadData()
        SQNetworkManager.shared.GET(urlString: bbs_list, parameters: nil ){
            (isSuccess, json, error) in
            if isSuccess {
                let data = json?["data"]
                let arr = data?["forum_list"]
                for dict in arr! {
                    let model = BBSModel.yy_model(with: dict.1.dictionaryObject!)
                    self.modelArr.append(model!)
                }
            }
        }
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
