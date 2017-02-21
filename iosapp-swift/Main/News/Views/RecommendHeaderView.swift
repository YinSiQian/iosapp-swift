//
//  RecommendHeaderView.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/21.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class RecommendHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupSubviews() {
        var rect = self.bounds
        rect.size.height -= 50
        let scrollView = SQCycleScrollView.init(frame: rect)
        self.addSubview(scrollView)
        
        var buttonRect = self.bounds
        buttonRect.origin.y = scrollView.frame.height + 10
        buttonRect.origin.x = 10
        buttonRect.size.height = self.bounds.height - scrollView.bounds.height - 20
        buttonRect.size.width = self.bounds.width - 20
        let button = UIButton.init(frame: buttonRect)
        button.setTitle("搜索锦囊", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.cornerRadius = button.bounds.height / 2
        self.addSubview(button)
        button.addTarget(self, action: #selector(RecommendHeaderView.showSearch), for: .touchUpInside)
    }
    
    @objc fileprivate func showSearch() {
        
    }
}
