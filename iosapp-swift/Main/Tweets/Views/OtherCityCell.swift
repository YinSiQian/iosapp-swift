//
//  OtherCityCell.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/27.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class OtherCityCell: UICollectionViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var cnname: UILabel!
    
    @IBOutlet weak var enname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.icon.layer.cornerRadius = 4
        self.icon.layer.masksToBounds = true
    }
    
    func setData(model: CityListModel?) {
        //icon.kf.setImage(with: model?.photo?.url())
        icon.sd_setImage(with: model?.photo?.url())
        cnname.text = model?.cnname
        enname.text = model?.enname
    }

}
