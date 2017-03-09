//
//  CommunityHeaderView.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/3/9.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class CommunityHeaderView: UIView {

   
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var column1_btn: UIButton!
    
    @IBOutlet weak var column2_btn: UIButton!
    
    @IBOutlet weak var column3_btn: UIButton!
    
    @IBOutlet weak var column4_btn: UIButton!
    
    @IBOutlet weak var column5_btn: UIButton!
    
    @IBOutlet weak var column1: UILabel!
    
    @IBOutlet weak var column2: UILabel!
    
    @IBOutlet weak var column3: UILabel!
    
    @IBOutlet weak var column4: UILabel!
    
    @IBOutlet weak var column5: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    fileprivate func setupSubviews() {
        
        let space = (screen_width - 4 * 40 - 20 - 20 - 20) / 4
        column1_btn.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        column2_btn.frame = CGRect(x: space + column1_btn.frame.maxX + space, y: 20, width: 40, height: 40)
        column3_btn.frame = CGRect(x: space + column2_btn.frame.maxX, y: 20, width: 40, height: 40)
        column4_btn.frame = CGRect(x: space + column3_btn.frame.maxX, y: 20, width: 40, height: 40)
        column5_btn.frame = CGRect(x: space + column4_btn.frame.maxX, y: 20, width: 40, height: 40)
        
        column1.snp.makeConstraints { (make) in
            make.centerX.equalTo(column1_btn)
            make.top.equalTo(column1_btn.snp.bottom).offset(5)
        }
        
        column2.snp.makeConstraints { (make) in
            make.centerX.equalTo(column2_btn)
            make.top.equalTo(column2_btn.snp.bottom).offset(5)
        }
        
        column3.snp.makeConstraints { (make) in
            make.centerX.equalTo(column3_btn)
            make.top.equalTo(column3_btn.snp.bottom).offset(5)
        }
        
        column4.snp.makeConstraints { (make) in
            make.centerX.equalTo(column4_btn)
            make.top.equalTo(column4_btn.snp.bottom).offset(5)
        }
        
        column5.snp.makeConstraints { (make) in
            make.centerX.equalTo(column5_btn)
            make.top.equalTo(column5_btn.snp.bottom).offset(5)
        }
    }
    
    
}
