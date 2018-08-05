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
        
        /**
         *  兼容iOS 8.0(没有storyboard reference)
         */
        self.addChildVc(storyboardName: "Home")
        self.addChildVc(storyboardName: "Live")
        self.addChildVc(storyboardName: "Follow")
        self.addChildVc(storyboardName: "Profile")
        
    }

    private func addChildVc(storyboardName: String) {
        
        /**
         *  通过storyboard获得控制器
         */
        let childVc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        
        /**
         *  添加子控制器
         */
        self.addChildViewController(childVc)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
