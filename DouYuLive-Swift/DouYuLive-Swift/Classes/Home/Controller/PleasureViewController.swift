//
//  PleasureViewController.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/12.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let kMenuViewH: CGFloat = 200

class PleasureViewController: BaseAnchorViewController {

    private lazy var pleasureViewModel: PleasureViewModel = PleasureViewModel()
    
    private lazy var pleasureMenuView: PleasureMenuView = {
        
        let pleasureMenuView = PleasureMenuView.pleasureMenuView()
        
        pleasureMenuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenWidth, height: kMenuViewH)
        
//        pleasureMenuView.backgroundColor = UIColor.randomColor()
        
        return pleasureMenuView
        
    }()

}

extension PleasureViewController {
    
    override func setUI() {
        
        super.setUI()
        
        self.collectionView.addSubview(self.pleasureMenuView)
        
        self.collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
        
    }
    
}

extension PleasureViewController {

    override func requestLoadData() {
        
        self.baseViewModel = self.pleasureViewModel
        
        self.pleasureViewModel.loadAllPleasureData {
            
            self.collectionView.reloadData()
            
            self.pleasureMenuView.groups = self.pleasureViewModel.anchorGroups
            
        }
    }
    
}

