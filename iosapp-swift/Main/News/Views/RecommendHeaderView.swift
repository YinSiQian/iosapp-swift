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
        self.backgroundColor = UIColor.white
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupSubviews() {
        var rect = self.bounds
        rect.size.height -= 50
      
        var buttonRect = self.bounds
        buttonRect.origin.y = rect.height + 10
        buttonRect.origin.x = 10
        buttonRect.size.height = self.bounds.height - rect.height - 20
        buttonRect.size.width = self.bounds.width - 20
        
        let button = UIButton.init(frame: buttonRect)
        button.setTitle("搜索目的地、锦囊、游记、特价、穷游er", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = button.bounds.height / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.orange.cgColor
        self.addSubview(button)
        
        button.addTarget(self, action: #selector(RecommendHeaderView.showSearch), for: .touchUpInside)
    }
    
    @objc fileprivate func showSearch() {
        print(#function)
    }
    
    func setData(modelArr: Array<SlideModel>) {
        guard !modelArr.isEmpty else {
            return
        }
        var rect = self.bounds
        rect.size.height -= 50
     
        var urls = [String]()
        for model in modelArr {
            urls.append(model.photo!)
        }
        let cycleView = SQCycleScrollView.init(frame: rect)
        cycleView.image_urls = urls
        cycleView.autoTime = 3.0
        self.addSubview(cycleView)
    }
}
