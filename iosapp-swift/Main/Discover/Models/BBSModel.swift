//
//  BBSModel.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/3/3.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class BBSModel: NSObject {

    var id: NSNumber?
    var name: String?
    var des: String?
    var total_threads: String?
    var photo: String?
    var types: TypesModel?
    
    public static func modelCustomPropertyMapper() -> [String : Any]? {
        return ["des": "description"]
    }
    
    public static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["types": TypesModel.self]
    }
}

class TypesModel: NSObject {
    
    var id: NSNumber?
    var name: String?
}
