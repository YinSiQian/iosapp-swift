//
//  RecommendCell.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/23.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class RecommendCell: UITableViewCell {

    @IBOutlet weak var cover: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var column: TagView!
    
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        shadowView.layer.shadowOpacity = 0.6
        shadowView.layer.shadowRadius = 2
        shadowView.layer.shouldRasterize = true
        self.selectionStyle = .none
        
    }

    func setData(model: EntryModel?) {
        
        SQNetworkManager.shared.downloadWebP(urlString: (model?.cover!)!) {
            [unowned self] (isSuccess, data, error) in
            if isSuccess {
                let decoder = YYImageDecoder.init(data: data!, scale: 2.0)
                let image = decoder?.frame(at: 0, decodeForDisplay: true)?.image
                self.cover.image = image!
            }
        }
    
        icon.sd_setImage(with: model?.icon_url?.url())
        title.text = model?.title
        subTitle.text = model?.subject
        column.text = model?.column
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
