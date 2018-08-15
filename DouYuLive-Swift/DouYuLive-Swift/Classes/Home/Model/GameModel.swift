//
//  GameModel.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/11.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class GameModel: NSObject {

    @objc var icon_url: String?
    @objc var tag_name: String?
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
