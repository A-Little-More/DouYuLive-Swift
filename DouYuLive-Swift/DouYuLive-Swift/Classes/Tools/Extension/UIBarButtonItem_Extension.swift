//
//  UIBarButtonItem_Extension.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/5.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /*
    class func createItem(imageName: String, highlightImageName: String, size: CGSize) -> UIBarButtonItem{
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        btn.setImage(UIImage(named: highlightImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
        
    }
     */
    
    /**
     *  Swift对类的扩展推荐使用下面的构造函数的方式，不推荐上面的新增方法的方式
     */
    
    /**
     *  在扩展中书写构造函数必须满足两个条件：
     *  1. 必须是便利构造函数（用convenience修饰）
     *  2. 在构造函数中必须明确调用一个自身的设计构造函数（self）
     */
    convenience init(imageName: String, highlightImageName: String = "", size: CGSize = CGSize.zero){
    
        let btn = UIButton()
    
        btn.setImage(UIImage(named: imageName), for: .normal)
    
        if(highlightImageName != ""){
            
            btn.setImage(UIImage(named: highlightImageName), for: .highlighted)
            
        }
        
        if(size == CGSize.zero){
            
            btn.sizeToFit()
            
        }else{
            
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
            
        }
    
        self.init(customView: btn)
    
    }
    
}
