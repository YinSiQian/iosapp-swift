//
//  CommunityModel.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/3/3.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class CommunityModel: NSObject {

    var id: NSNumber?
    var title: String?
    var bigpic_arr: Array<String>?
    var author: String?
    var user_id: String?
    var avatar: String?
    var forum: String?
    var forun_id: String?
    var reply_num: NSNumber?
    var reply_time: String?
    var is_hot: NSNumber?
    var is_best: NSNumber?
    var user_qualif: String?
    var appview_url: String?
}

class RecommendCommunityModel: NSObject {
    var icon_type: String?
    var link_url: String?
    var sud_id: String?
    var tag_name: String?
    var tag_cover: String?
}

class ColumnModel: NSObject {
    var icon_type: String?
    var icon: String?
    var icon_pic: String?
    var link_url: String?
    var sud_id: String?
}
