//
//  AnchorGroup.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/7.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    @objc var icon_url: String?
    @objc var small_icon_url: String?
    @objc var tag_name: String?
    @objc var tag_id: Int = 0
    @objc var push_vertical_screen: Int = 0
    @objc var push_nearby: Int = 0
    @objc var room_list: [[String: NSObject]]?{
        didSet{
            guard let room_list = room_list else{return}
            for dic in room_list {
                self.anchors.append(AnchorModel(dict: dic))
            }
        }
    }
    
    //所有的主播列表
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict: [String: Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
