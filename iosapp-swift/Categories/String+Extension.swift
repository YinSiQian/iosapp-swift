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
    
    func isURL() -> Bool {
        guard self.hasPrefix("http") || self.hasPrefix("https") else {
            return false
        }
        return true
    }
    
    func width(font: UIFont) -> CGFloat {
        let string = self as NSString
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        let attribute = [NSFontAttributeName: font, NSParagraphStyleAttributeName: style]
        let size = string.boundingRect(with: CGSize(width: screen_width, height: screen_height), options: .usesLineFragmentOrigin, attributes: attribute, context: nil)
        return size.width
    }
}
