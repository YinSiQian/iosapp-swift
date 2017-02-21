//
//  String+Extension.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/21.
//  Copyright © 2017年 ysq. All rights reserved.
//

import Foundation

extension String {
    func url() -> URL? {
        guard self.hasPrefix("http") || self.hasPrefix("https") else {
            assertionFailure("it is not a url String, please check this url string")
            return nil
        }
        return URL(string: self)!
    }
}
