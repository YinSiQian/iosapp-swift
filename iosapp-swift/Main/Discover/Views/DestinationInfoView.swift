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
    
    var model: GroupModel? {
        willSet(newModel) {
            icon.sd_setImage(with: newModel?.photo?.url())
            count.text = newModel?.total_threads
            des.text = newModel?.des
            name.text = newModel?.name
        }
    }
    
    fileprivate func setupSubviews() {
        icon = UIImageView()
        icon.layer.cornerRadius = 4
        icon.layer.masksToBounds = true
        contentView.addSubview(icon)
        
        icon1 = UIImageView()
        icon1.image = UIImage(named: "com_post_icon_9x11_")
        contentView.addSubview(icon1)
        
        name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 12)
        contentView.addSubview(name)
        
        des = UILabel()
        des.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(des)
        
        count = UILabel()
        count.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(count)
        
    }
    
    fileprivate func makeConstraints() {
        icon.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.bottom.equalTo(self).offset(-15)
            make.left.equalTo(self).offset(15)
            make.width.equalTo(40)
        }
        
        name.setContentCompressionResistancePriority(UILayoutPriorityFittingSizeLevel, for: UILayoutConstraintAxis.horizontal)
        name.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        name.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(icon.snp.right).offset(10)
            make.right.equalTo(icon1.snp.left).offset(-10).priority(250)
        }
        
        des.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-15)
            make.left.equalTo(icon.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        count.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        
        count.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-10)
        }
        
        icon1.snp.makeConstraints { (make) in
            make.right.equalTo(count.snp.left).offset(-3)
            make.top.equalTo(self).offset(15)
        }
    }

}
