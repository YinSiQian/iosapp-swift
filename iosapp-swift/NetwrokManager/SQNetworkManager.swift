//
//  SQNetworkManager.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/17.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

import Alamofire

import SwiftyJSON

class SQNetworkManager: NSObject {
    
    typealias compeletionHandler = (_ success: Bool, _ responseObject: JSON?, _ error: Error?) -> Void
    
    static let shared = SQNetworkManager()
    
    var dataRequest: Request?

    private override init() {
        
    }
}

extension SQNetworkManager {
    
     func getRequest(urlString: String, parameters: [String: Any]?, compeletionHandler: @escaping compeletionHandler) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.dataRequest = Alamofire.request(urlString, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch response.result {
                case .success(let value):
                    //print(JSON(value))
                    let json = JSON(value)
                    compeletionHandler(true, json, nil)
                case .failure(let error):
                    print(error)
                    compeletionHandler(false, nil, error)
                }
        }
        
    }
    
    func isAccessNetwork() -> Bool? {
        return false
    }
    func cancel() {
        self.dataRequest?.cancel()
    }
    
}
