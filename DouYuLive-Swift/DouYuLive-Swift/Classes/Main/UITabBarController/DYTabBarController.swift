//
//  DYTabBarController.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/4.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class DYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarTitles: [String] = ["首页","直播","关注","我的"]
        
        let tabbarNormalImages: [String] = ["btn_home_normal","btn_column_normal","btn_live_normal","btn_user_normal"]
        
        let tabbarSelectedImages: [String] = ["btn_home_selected","btn_column_selected","btn_live_selected","btn_user_selected"]
        
        let controllersName: [String] = ["HomeViewController","LiveViewController","FollowViewController","ProfileViewController"]
        
        var viewControllers: [UIViewController] = []
        
        for i in 0..<tabBarTitles.count {
            
            /**
             * NSClassFromString 的参数需要用 项目的名称 + . + 类名称
             */
            let viewControllerClass = NSClassFromString("DouYuLive_Swift." + controllersName[i]) as! UIViewController.Type
            
            let VC = viewControllerClass.init()
            
            let navigationController = DYNavigationController(rootViewController: VC)
            
            navigationController.tabBarItem.title = tabBarTitles[i]
            
            navigationController.tabBarItem.image = UIImage(named: tabbarNormalImages[i])?.withRenderingMode(.alwaysOriginal)
            
            navigationController.tabBarItem.selectedImage = UIImage(named: tabbarSelectedImages[i])?.withRenderingMode(.alwaysOriginal)
            
            viewControllers.append(navigationController)
            
        }
        
        self.viewControllers = viewControllers
        
    }

}
