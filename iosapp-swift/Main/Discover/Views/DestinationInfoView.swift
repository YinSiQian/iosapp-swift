//
//  DestinationInfoView.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/3/3.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class DestinationInfoView: UITableViewCell {

    private var icon: UIImageView!
    
    private var name: UILabel!
    
    private var des: UILabel!
    
    private var icon1: UIImageView!
    
    private var count: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        icon = UIImageView()
        icon.layer.cornerRadius = 4
        icon.layer.masksToBounds = true
        contentView.addSubview(icon)
        
        icon1 = UIImageView()
        contentView.addSubview(icon1)
        
        name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 12)
        name.backgroundColor = UIColor.black
        contentView.addSubview(name)
        
        des = UILabel()
        des.font = UIFont.systemFont(ofSize: 10)
        des.backgroundColor = UIColor.gray
        contentView.addSubview(des)
        
        count = UILabel()
        count.font = UIFont.systemFont(ofSize: 10)
        count.backgroundColor = UIColor.gray
        contentView.addSubview(count)
        
    }
    
    fileprivate func makeConstraints() {
        icon.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-5)
            make.left.equalTo(self).offset(5)
            make.width.equalTo(40)
        }
        
        name.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(7)
            make.left.equalTo(icon.snp.right).offset(10)
        }
        
        des.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-7)
            make.left.equalTo(icon.snp.right).offset(10)
        }
        
        count.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(7)
            make.right.equalTo(self).offset(-5)
        }
        
        icon1.snp.makeConstraints { (make) in
            make.right.equalTo(count.snp.left).offset(-3)
            make.top.equalTo(self).offset(7)
            make.left.greaterThanOrEqualTo(self.name.snp.right).offset(10)
        }
    }

}
