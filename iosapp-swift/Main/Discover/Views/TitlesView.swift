//
//  TitlesView.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/3/3.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class TitlesView: UIView {
    
    var titles = [String]()
    
    typealias didItemBlock = (_ index: Int) -> ()
    
    var block: didItemBlock?
    
    var btnArr = [UIButton]()
    
    var selectedIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(titles: [String]?, block: @escaping didItemBlock) {
        self.init(frame: CGRect.zero)
        self.block = block
        self.titles = titles!
        self.addButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    fileprivate func addButton() {
        var length: CGFloat = 0.0
        let space: CGFloat = 30.0
        for (index, title) in titles.enumerated() {
            let width = title.width(font: UIFont.boldSystemFont(ofSize: 14))
            let button = UIButton(frame: CGRect(x: length, y: 0.0, width: width, height: 40.0))
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            button.setTitleColor(UIColor.init(hex6: 0xE9E9E9), for: .normal)
            button.tag = index + 1
            button.addTarget(self, action: #selector(TitlesView.clickButton(sender:)), for: .touchUpInside)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            self.addSubview(button)
            self.btnArr.append(button)
            if index == 0 {
                button.isSelected = true
            }
            length += (space + width)
        }
        length -= space
        self.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: length, height: 40))

    }
    
    @objc fileprivate func clickButton(sender: UIButton) {
        if selectedIndex == sender.tag - 1 {
            return;
        }
        selectedIndex =  sender.tag - 1
        for btn in btnArr {
            if btn.tag != sender.tag {
                btn.isSelected = false
            } else {
                btn.isSelected = true
            }
        }
        self.block?(selectedIndex)
    }
    
    func selectedButton(with: Int) {
        for btn in btnArr {
            if btn.tag != with {
                btn.isSelected = false
            }
        }
    }

}
