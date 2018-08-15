//
//  NSDate_Extension.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/7.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

extension NSDate {
    
    static func getCurrentTimeInterval() -> String {
        
        let nowDate = NSDate()
        
        let interval = nowDate.timeIntervalSince1970
        
        return String(interval)
        
    }
    
}
