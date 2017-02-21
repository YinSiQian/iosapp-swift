//
//  AdverticeImage.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/21.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class AdverticeImage: UIView {
    
    var imageView: UIImageView!

    var timeBtn: UIButton!

    var timer: Timer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        self.imageView = UIImageView.init(frame: self.bounds)
        self.addSubview(self.imageView)
        
        timeBtn = UIButton.init(frame: CGRect.init(x: screen_width - 70, y: 40, width: 50, height: 25))
        timeBtn.setTitle("跳过 3", for: .normal)
        timeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        timeBtn.setTitleColor(UIColor.black, for: .normal)
        timeBtn.backgroundColor = UIColor.orange
        timeBtn.layer.cornerRadius = 12.5
        timeBtn.addTarget(self, action: #selector(AdverticeImage.jumpAD), for: .touchUpInside)
        self.addSubview(timeBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func coundown() {
        var times = 3
        timer = Timer.scheduledTimer(withTimeInterval: 0.9, repeats: true, block: {
            [unowned self] (_) in
            if times == 0 {
                self.removed()
            }
            let title = "跳过" + " \(times)"
            self.timeBtn.setTitle(title, for: .normal)
            times -= 1

        })
    }
    
    func removed() {
        timer.invalidate()
        var rect = self.frame
        rect.origin.y = -screen_height
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .beginFromCurrentState, animations: {
            self.frame = rect
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    @objc fileprivate func jumpAD() {
        timer.invalidate()
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
        }
    }

    deinit {
        print("it is dealloc")
        timer = nil
    }

}
