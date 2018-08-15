//
//  AnchorModel.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/7.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    @objc var room_name: String?
    @objc var vertical_src: String?
    @objc var nickname: String?
    @objc var room_id: Int = 0
    @objc var online: Int = 0
    @objc var isVertical: Int = 0 //0 电脑直播 1 手机直播
    @objc var anchor_city: String? //所在城市
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
