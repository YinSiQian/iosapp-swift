//
//  SQNewsTableViewCell.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/17.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class SQNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var body: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var model: SQNewsModel? {
        willSet(newModel) {
            self.title.text = newModel?.title
            self.username.text = newModel?.author
            self.comment.text = newModel?.commentCount?.stringValue
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
