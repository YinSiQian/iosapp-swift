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
    
    typealias completionHandler = (_ success: Bool, _ responseObject: JSON?, _ error: Error?) -> Void
    
    typealias downloadHandler = (_ success: Bool, _ responseData: Data?, _ error: Error?) -> Void
    
    static let shared = SQNetworkManager()
    
    private override init() {
        
    }
}

extension SQNetworkManager {
    
    func GET(urlString: String, parameters: [String: Any]?, compeletionHandler:  @escaping completionHandler) {
        
        let user = URLRouter(username: urlString)
                
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(user, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch response.result {
                    
                case .success(let value):
                    let json = JSON(value)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: request_notification), object: nil, userInfo: ["result":"success"])
                    compeletionHandler(true, json, nil)
                    
                case .failure(let error):
                    print(error)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: request_notification), object: nil, userInfo: ["result":"failure"])
                }
        }
        
    }
    
    func downloadWebP(urlString: String, completionHandler: @escaping downloadHandler) {
        Alamofire.request(urlString, method: .get).responseData {
            (responseData) in
            switch responseData.result {
                
            case .success(let value):
                completionHandler(true, value, nil)
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func isAccessNetwork() -> Bool? {
        return true
    }
    
}


