//
//  BaseViewModel.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/13.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class BaseViewModel {

    //懒加载数组
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    
}

extension BaseViewModel {
    
    //请求主播信息
    func loadAnchorData(URLStr: String, method: MethodType, parameters: [String: Any]? = nil, finishedCallback: @escaping () -> ()) {
        
        NetworkTools.requestData(urlString: URLStr, menthod: method, parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String: Any] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {return}
            
            for dic in dataArray {
                
                let group = AnchorGroup(dict: dic)
                
                self.anchorGroups.append(group)
                
            }
            
            finishedCallback()
            
        }
        
    }
    
}
