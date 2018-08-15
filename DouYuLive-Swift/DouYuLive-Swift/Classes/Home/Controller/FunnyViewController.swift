//
//  FunnyViewController.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/13.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let kTopMargin: CGFloat = 10

class FunnyViewController: BaseAnchorViewController {

    private lazy var funnyViewModel: FunnyViewModel = FunnyViewModel()

}

extension FunnyViewController {
    
    override func setUI() {
        super.setUI()
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        self.collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
        
    }
    
}

extension FunnyViewController {
    
    override func requestLoadData() {
        
        self.baseViewModel = self.funnyViewModel
        
        self.funnyViewModel.loadFunnyData {
            
            self.collectionView.reloadData()
            
        }
        
    }
    
}

