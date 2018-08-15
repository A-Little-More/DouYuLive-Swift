//
//  NetworkTools.swift
//  AlamofireDemo
//
//  Created by lidong on 2018/8/7.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {

    class func requestData(urlString: String, menthod: MethodType, parameters: [String : Any]? = nil, finishedCallback: @escaping (_ value: Any) -> Void) {
        
        let requestMethod: HTTPMethod
        
        switch menthod {
        case .GET:
            requestMethod = .get
        case .POST:
            requestMethod = .post
        }
        
        Alamofire.request(urlString, method: requestMethod, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                
                print(response.result.error as Any)
                return
                
            }
            
            finishedCallback(result)
        }
        
    }
    
}
