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

extension Notification.Name {
    static let notificationName = Notification.Name(rawValue: "notificationName")
}

class EventReport {
    
    static let share = EventReport()
    
    func reportEvent(_ eventId: EventID, withParam: [String: Any]? = nil) {
        
    }
    
}

struct EventID: RawRepresentable {
    
    typealias RawValue = String
    
    var rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
}

extension EventID {
    static let LoginPageExposure = EventID(rawValue: "LoginPageExposure")
}

extension NSObject {
    private struct AssociatedKeys {
         static var personName = "rt_personName"
    }
    
    var personName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.personName) as? String
        }
        
        set {
            if let newValue = newValue {
              objc_setAssociatedObject(self, &AssociatedKeys.personName, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}


