//
//  DYNavigationController.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/5.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class DYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1. 获取系统的pop手势
        guard let systemGestrue = self.interactivePopGestureRecognizer else {return}
        //2. 获取手势添加到的view中
        guard let gestureView = systemGestrue.view else {return}
        //3. 获取target/action
        /*
        //3.1(利用运行时查看所有的属性名称)
        var count: UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!

        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        
        let targets = systemGestrue.value(forKey: "_targets") as? [NSObject]
        
        guard let targetObjc = targets?.first else {return}
        
        //取出target
        guard let target = targetObjc.value(forKey: "target") else {return}
        
        //取出action
//        guard let action = targetObjc.value(forKey: "action") as? Selector else {return}
        let action = Selector(("handleNavigationTransition:"))
        
        let panGesture = UIPanGestureRecognizer()
        
        gestureView.addGestureRecognizer(panGesture)
        
        panGesture.addTarget(target, action: action)
        
        print(targetObjc)
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count >= 1 {
          
            viewController.hidesBottomBarWhenPushed = true
            
        }
        
        super.pushViewController(viewController, animated: animated)
        
    }

}
