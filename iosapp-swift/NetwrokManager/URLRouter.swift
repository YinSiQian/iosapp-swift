//
//  URLRouter.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/21.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit
import Alamofire


class URLRouter: NSObject {
    
    var username: String?
    
    let userInfo = "&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&lat=22.54332243396407&lon=113.935176341206&track_app_channel=AppStore&track_app_version=7.4&track_device_info=iPhone6&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios10.0.2&v=1"
    

    init(username: String?) {
        self.username = username
    }

}

extension URLRouter: URLConvertible {
    static let baseURLString = "http://open.qyer.com/"
    
    func asURL() throws -> URL {
        let urlString = URLRouter.baseURLString + username! + userInfo
        return try urlString.asURL()
    }
    
    func url() -> String? {
        return URLRouter.baseURLString + username! + userInfo
    }
}
