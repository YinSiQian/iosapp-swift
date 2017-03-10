//
//  CommunityCardView.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/3/10.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class CommunityCardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var button: UIButton!
    
    var title: UILabel!

    var model: RecommendCommunityModel? {
        didSet {
            title.text = model?.tag_name
            button.sd_setImage(with: model?.tag_cover?.url(), for: .normal)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        button = UIButton(frame: self.bounds)
        self.addSubview(button)
        
        let maskView = UIView(frame: self.bounds)
        maskView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        maskView.isUserInteractionEnabled = true
        self.addSubview(maskView)
        
        title = UILabel()
        title.textColor = UIColor.white
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(title)
        
        title.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
    
    
}
