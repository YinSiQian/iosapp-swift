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
        if self == "" {
            return URL(string: "")
        }
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
        return self.size(font: font).width
    }
    
    func height(font: UIFont) -> CGFloat {
        return self.size(font: font).height
    }
    
    func size(font: UIFont) -> CGSize {
        let string = self as NSString
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        let attribute = [NSFontAttributeName: font, NSParagraphStyleAttributeName: style]
        let rect = string.boundingRect(with: CGSize(width: screen_width, height: screen_height), options: .usesLineFragmentOrigin, attributes: attribute, context: nil)
        return rect.size
    }
}
