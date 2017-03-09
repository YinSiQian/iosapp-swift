//
//  CommunityCell.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/3/9.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class CommunityCell: UITableViewCell {

    var user_icon: UIImageView!
    
    var user_name: UILabel!
    
    var title: UILabel!
    
    var destination: UILabel!
    
    var post_time: UILabel!
    
    var replys: UILabel!
    
    var time_icon: UIImageView!
    
    var replys_icon: UIImageView!
    
    var line: UIView!
    
    var images_arr = [UIImageView]()
    
    var model: CommunityModel? {
        didSet {
            user_icon.sd_setImage(with: model?.avatar?.url())
            user_name.text = model?.author
            title.text = model?.title
            destination.text = model?.forum
            post_time.text = model?.reply_time
            replys.text = model?.reply_num?.stringValue
            
            if !(model?.bigpic_arr?.isEmpty)! {
                
                //避免图片错位.
                for item in images_arr {
                    item.removeFromSuperview()
                }
                let space: CGFloat = 10.0
                let image_width =
                    ((screen_width - 65 - 20) - space * 2.0) / 3
                
                for (index, url) in (model?.bigpic_arr?.enumerated())! {
                    
                    let x = 65.0 + CGFloat(index) * (image_width + space)
                    let imageView = UIImageView(frame: CGRect(x: x, y: 34 + 42, width: image_width, height: 80))
                    imageView.layer.cornerRadius = 4
                    imageView.layer.masksToBounds = true
                    imageView.sd_setImage(with: url.url())
                    contentView.addSubview(imageView)
                    self.images_arr.append(imageView)
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()

        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupSubviews()
        makeConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        user_icon = UIImageView()
        user_icon.layer.cornerRadius = 20
        user_icon.layer.masksToBounds = true
        contentView.addSubview(user_icon)
        
        time_icon = UIImageView()
        time_icon.image = UIImage(named: "time_icon")
        contentView.addSubview(time_icon)
        
        replys_icon = UIImageView()
        replys_icon.image = UIImage(named: "comment_icon")
        contentView.addSubview(replys_icon)

        
        user_name = UILabel()
        user_name.font = UIFont.systemFont(ofSize: 12)
        user_name.textColor = UIColor.gray
        contentView.addSubview(user_name)
        
        title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.textColor = UIColor.black
        title.numberOfLines = 2
        contentView.addSubview(title)
        
        destination = UILabel()
        destination.font = UIFont.systemFont(ofSize: 12)
        destination.textColor = UIColor.init(hex6: 0x24CF5F)
        contentView.addSubview(destination)
        
        replys = UILabel()
        replys.font = UIFont.systemFont(ofSize: 12)
        replys.textColor = UIColor.gray
        contentView.addSubview(replys)

        post_time = UILabel()
        post_time.font = UIFont.systemFont(ofSize: 12)
        post_time.textColor = UIColor.gray
        contentView.addSubview(post_time)

        line = UIView()
        line.backgroundColor = UIColor.init(hex6: 0xE6E6E6)
        contentView.addSubview(line)
    }
    
    fileprivate func makeConstraints() {
        
        user_icon.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(15)
            make.width.height.equalTo(40)
        }
        
        user_name.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(user_icon.snp.right).offset(10)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(user_name.snp.bottom).offset(10)
            make.left.equalTo(user_icon.snp.right).offset(10)
            make.right.equalTo(self).offset(-15)
        }
        
        destination.snp.makeConstraints { (make) in
            make.bottom.equalTo(line.snp.top).offset(-10)
            make.leading.equalTo(user_name.snp.leading)
            make.right.equalTo(time_icon.snp.left).offset(-15)
        }
        
        time_icon.snp.makeConstraints { (make) in
            make.bottom.equalTo(line.snp.top).offset(-10)
            make.right.equalTo(post_time.snp.left).offset(-5)
        }
        
        post_time.snp.makeConstraints { (make) in
            make.bottom.equalTo(line.snp.top).offset(-10)
            make.right.equalTo(replys_icon.snp.left).offset(-10)
        }
        
        replys_icon.snp.makeConstraints { (make) in
            make.bottom.equalTo(line.snp.top).offset(-10)
            make.right.equalTo(replys.snp.left).offset(-5)
        }
        
        replys.snp.makeConstraints { (make) in
            make.bottom.equalTo(line.snp.top).offset(-10)
            make.right.equalTo(self).offset(-20)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self).offset(0)
            make.height.equalTo(5)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
