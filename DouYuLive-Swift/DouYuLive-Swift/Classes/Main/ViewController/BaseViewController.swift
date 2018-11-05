//
//  BaseViewController.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/16.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //定义一个展示内容的view
    var contentView: UIView?
    
    lazy var animationImageView: UIImageView = { [unowned self] in
        
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        
        imageView.center = self.view.center
        
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        
        imageView.animationDuration = 0.5
        
        imageView.animationRepeatCount = LONG_MAX
        
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        
        return imageView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUI()
        
    }

}

extension BaseViewController {
    
    @objc func setUI() {
        
        contentView?.isHidden = true
        
        self.view.addSubview(self.animationImageView)
        
        self.animationImageView.startAnimating()
     
        self.view.backgroundColor = UIColor.white
    }
    
    func loadDataFinished() {
        
        self.animationImageView.stopAnimating()
        
        self.animationImageView.isHidden = true
        
        self.contentView?.isHidden = false
        
    }
    
}

