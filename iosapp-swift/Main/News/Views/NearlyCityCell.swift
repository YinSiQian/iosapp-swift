//
//  NearlyCityCell.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/22.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class NearlyCityCell: UITableViewCell {

    @IBOutlet weak var icon_city: UIImageView!
    
    @IBOutlet weak var name_city: UILabel!
    
    @IBOutlet weak var nearlyPlay: UIButton!
    
    @IBOutlet weak var nearlyFood: UIButton!
    
    @IBOutlet weak var nearlyGuide: UIButton!
    
    @IBOutlet weak var nearlyPoilike: UIButton!

    @IBOutlet weak var nearly_city_1: UIButton!
    
    @IBOutlet weak var nearly_city_2: UIButton!
    
    @IBOutlet weak var nearly_city_3: UIButton!
    
    @IBOutlet weak var icon_discount: UIImageView!
    
    @IBOutlet weak var discount_btn: UIButton!
    
    @IBOutlet weak var food_name: UILabel!
    
    @IBOutlet weak var play_name: UILabel!
    
    @IBOutlet weak var guide_name: UILabel!
    
    @IBOutlet weak var poilike_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeConstraints()
        setupSubviews()
        self.selectionStyle = .none
    }
    
    fileprivate func makeConstraints() {
        let space = (screen_width - 4 * 40 - 20 - 20 - 20) / 3
        nearlyPlay.frame = CGRect.init(x: 20, y: 20, width: 40, height: 40)
        nearlyFood.frame = CGRect.init(x: 20 + 40 + space, y: 20, width: 40, height: 40)
        nearlyGuide.frame = CGRect.init(x: nearlyFood.frame.maxX + space, y: 20, width: 40, height: 40)
        nearlyPoilike.frame = CGRect.init(x: nearlyGuide.frame.maxX + space, y: 20, width: 40, height: 40)
        
        play_name.snp.makeConstraints { (make) in
            make.centerX.equalTo(nearlyPlay)
            make.top.equalTo(nearlyPlay.snp.bottom).offset(5)
        }
        
        food_name.snp.makeConstraints { (make) in
            make.centerX.equalTo(nearlyFood)
            make.top.equalTo(nearlyFood.snp.bottom).offset(5)
        }
        
        guide_name.snp.makeConstraints { (make) in
            make.centerX.equalTo(nearlyGuide)
            make.top.equalTo(nearlyGuide.snp.bottom).offset(5)
        }
        
        poilike_name.snp.makeConstraints { (make) in
            make.centerX.equalTo(nearlyPoilike)
            make.top.equalTo(nearlyPoilike.snp.bottom).offset(5)
        }
    }
    
    fileprivate func setupSubviews() {
        nearly_city_1.layer.cornerRadius = 15
        nearly_city_1.layer.borderColor = UIColor.init(hex6: 0x45BC8C).cgColor
        nearly_city_1.layer.borderWidth = 1
        nearly_city_1.layer.masksToBounds = true
        
        nearly_city_2.layer.cornerRadius = 15
        nearly_city_2.layer.borderColor = UIColor.init(hex6: 0x45BC8C).cgColor
        nearly_city_2.layer.borderWidth = 1

        nearly_city_2.layer.masksToBounds = true

        nearly_city_3.layer.cornerRadius = 15
        nearly_city_3.layer.borderColor = UIColor.init(hex6: 0x45BC8C).cgColor
        nearly_city_3.layer.borderWidth = 1
        nearly_city_3.layer.masksToBounds = true

        discount_btn.layer.cornerRadius = 15
        discount_btn.layer.borderColor = UIColor.init(hex6: 0xF98471).cgColor
        discount_btn.layer.borderWidth = 1
        discount_btn.layer.masksToBounds = true

    }

    func setData(model: NearRecommendModel?) {
        
        nearlyPlay.sd_setBackgroundImage(with: model?.tab?.first?.icon_url?.url(), for: .normal)
        play_name.text = model?.tab?.first?.name
        
        nearlyFood.sd_setBackgroundImage(with: model?.tab?[1].icon_url?.url(), for: .normal)
        food_name.text = model?.tab?[1].name
        
        nearlyGuide.sd_setBackgroundImage(with: model?.tab?[2].icon_url?.url(), for: .normal)
        guide_name.text = model?.tab?[2].name

        nearlyPoilike.sd_setBackgroundImage(with: model?.tab?[3].icon_url?.url(), for: .normal)
        poilike_name.text = model?.tab?[3].name

        nearly_city_1.setTitle(model?.recommend_city?.first?.city_name, for: .normal)
        nearly_city_2.setTitle(model?.recommend_city?[1].city_name, for: .normal)
        nearly_city_3.setTitle(model?.recommend_city?[2].city_name, for: .normal)

        icon_city.sd_setImage(with: model?.cover?.url())
        name_city.text = model?.city_name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
