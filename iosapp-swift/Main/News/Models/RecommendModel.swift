//
//  RecommendModel.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/21.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class RecommendModel: NSObject {

    var slide: Array<SlideModel>?
    var keyword: String?
    var comment_entry: NSDictionary?
    var entry: Array<FeedModel>?
    
    public static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["slide": SlideModel.self, "entry": FeedModel.self]
    }
    
}

class SlideModel: NSObject {
    var url: String?
    var photo: String?
    var is_ads: NSNumber?
}

class FeedModel: NSObject {
    var id: NSNumber?
    var type: String?
    var title: String?
    var url: String?
    var cover: String?
    var author: Dictionary<String, String>? = [:]
    var subject: String?
    var subitems: Array<Any>?
    var icon_url: String?
    var up: NSNumber?
}

class NearRecommendModel: NSObject {
    var title: String?
    var city_id: NSNumber?
    var type: NSNumber?
    var city_name: String?
    var cover: String?
    var tab: Array<TabModel>?
    var recommend_city: Array<RecommendCityModel>?
    
    public static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["tab": TabModel.self, "recommend_city": RecommendCityModel.self]
    }
}

class TabModel: NSObject {
    var name: String?
    var icon_type: String?
    var icon_url: String?
}

class RecommendCityModel: NSObject {
    var id: NSNumber?
    var city_name: String?
    var city_type: String?
}


