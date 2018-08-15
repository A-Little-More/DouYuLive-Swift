//
//  Common.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/6.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

let kStatusBarHeight: CGFloat = 20
let kNavigationBarHeight: CGFloat = 44
let kTabBarHeight: CGFloat = 49
let kScreenWidth: CGFloat = UIScreen.main.bounds.width
let kScreenHeight: CGFloat = UIScreen.main.bounds.height

func x(_ object: UIView) -> CGFloat {
    return object.frame.origin.x
}
func y(_ object: UIView) -> CGFloat {
    return object.frame.origin.y
}
func w(_ object: UIView) -> CGFloat {
    return object.frame.size.width
}
func h(_ object: UIView) -> CGFloat {
    return object.frame.size.height
}
