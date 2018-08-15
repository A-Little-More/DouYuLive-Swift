//
//  PleasureMenuView.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/13.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class PleasureMenuView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    //数据
    var groups: [AnchorGroup]? {
        
        didSet {
            
            self.collectionView.reloadData()
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.autoresizingMask = []
        
        self.collectionView.register(UINib(nibName: "PleasureMenuCollectionCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: w(self.collectionView), height: h(self.collectionView))
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.isPagingEnabled = true
    }

}


extension PleasureMenuView {
    //快速初始化xib方法
    static func pleasureMenuView() -> PleasureMenuView {
        return Bundle.main.loadNibNamed("PleasureMenuView", owner: nil, options: nil)?.first as! PleasureMenuView
    }
    
}

extension PleasureMenuView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let groups = self.groups else { return 0 }
        
        let pageNum = (groups.count - 1) / 8 + 1
        
        self.pageControl.numberOfPages = pageNum
        
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! PleasureMenuCollectionCell
        
        setupCellDataWith(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func setupCellDataWith(cell: PleasureMenuCollectionCell, indexPath: IndexPath) {
        // 第0页：0 ~ 7
        // 第1页：8 ~ 15
        // 第2页：16 ~ 23
        let startIndex = indexPath.row * 8
        var endIndex = (indexPath.row + 1) * 8 - 1
        
        if endIndex > groups!.count - 1{
            endIndex = groups!.count - 1
        }
        
        cell.groups = Array(self.groups![startIndex...endIndex])
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollOffsetX = scrollView.contentOffset.x + w(scrollView) / 2.0
        
        self.pageControl.currentPage = Int(scrollOffsetX / w(scrollView))
        
    }
    
}

