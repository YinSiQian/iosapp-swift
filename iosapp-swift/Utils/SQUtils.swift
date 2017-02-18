//
//  SQUtils.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/18.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class SQUtils: NSObject {
    
    static func timestamp(dateString: String) -> String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = dataFormatter.date(from: dateString)
        let timeInterval = date?.timeIntervalSince1970
        let now = NSDate()
        let delta = now.timeIntervalSince1970 - timeInterval!
        var timeStamp: String? = nil
        if delta / 3600.0 < 1 {
            if delta / 60.0 <= 2 {
                timeStamp = "刚刚"
            } else {
                timeStamp = "\(Int(delta / 60))" + "分钟前"
            }
        }
        if delta / 3600.0 > 1 && delta / 86400 < 1 {
            timeStamp = "\(Int(delta / 3600))" + "小时前"
        }
        if delta / 86400.0 > 1 && delta / 86400.0 < 15 {
            timeStamp = "\(Int(delta / 86400))" + "天前"
        }
        if delta / 86400.0 >= 15 {
            timeStamp = dateString
        }
        return timeStamp!
        
    }

}
