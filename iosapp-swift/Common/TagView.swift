//
//  TagView.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/24.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class TagView: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        config()
    }
    
    fileprivate func config() {
        self.backgroundColor = UIColor.init(hex6: 0x24CF5F)
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 10)
        self.textAlignment = .center
    }
    

    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

}
