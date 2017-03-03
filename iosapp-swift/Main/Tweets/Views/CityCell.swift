//
//  CityCell.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/27.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class CityCell: UICollectionViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var cnname: UILabel!
    
    @IBOutlet weak var enname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cnname.font = UIFont.boldSystemFont(ofSize: 14)
        self.contentView.layer.cornerRadius = 4
        self.contentView.layer.masksToBounds = true
    }
    
    func setData(model: CityListModel?) {
        //icon.kf.setImage(with: model?.photo?.url())
        icon.sd_setImage(with: model?.photo?.url())
        cnname.text = model?.cnname
        enname.text = model?.enname
    }

}
