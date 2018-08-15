//
//  CycleModel.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/8.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    @objc var title: String?
    @objc var pic_url: String?
    @objc var room: [String: NSObject]?{
        
        didSet {
            
            guard let room = room else {
                return
            }
            
            anchor = AnchorModel(dict: room)
        }
        
    }
    
    var anchor: AnchorModel?
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
