//
//  PlaceModel.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/27.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class PlaceModel: NSObject {
    
    var tagname: String?
    var tagdata: tagDataModel?

    public static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["tagdata": tagDataModel.self]
    }
}

class tagDataModel: NSObject {
    var citylist: Array<CityListModel>?
    var countrylist: Array<CityListModel>?
    var citycount: NSNumber?
    var countrycount: NSNumber?
    
    public static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["citylist": CityListModel.self,"countrylist": CityListModel.self]
    }
}

class CityListModel: NSObject {
    var id: NSNumber?
    var cnname: String?
    var enname: String?
    var photo: String?
    var flag: NSNumber?
}
