//
//  BaseAnchorViewController.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/13.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let kitemMargin: CGFloat = 10
private let kHeaderViewH: CGFloat = 50

let kItemW: CGFloat = (kScreenWidth - 3 * kitemMargin) / 2.0
let kNormalItemH: CGFloat = kItemW * 3 / 4
let kPrettyItemH: CGFloat = kItemW * 4 / 3

let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class BaseAnchorViewController: UIViewController {

    //MARK: 定义属性
    var baseViewModel: BaseViewModel!
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 10
        
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        
        layout.sectionInset = UIEdgeInsetsMake(0, kitemMargin, 0, kitemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        /**
         *  设置此属性 使得随着父视图的变化而变化（宽，高）
         */
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        //        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "NormalLiveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "PrettyLiveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        collectionView.register(UINib(nibName: "RecommendCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
        
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.requestLoadData()
    }

}


extension BaseAnchorViewController {
    
    @objc func setUI() {
        
        self.view.addSubview(self.collectionView)
        
        //        self.collectionView.addSubview(self.cycleView)
        //
        //        self.collectionView.addSubview(self.gameView)
        //
        //        //设置collectionView的内边距,目的让轮播图显示出来
        //        self.collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
    
}

extension BaseAnchorViewController {
    
    @objc func requestLoadData() {
        
    }
    
}

extension BaseAnchorViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @objc func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.baseViewModel.anchorGroups.count
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let anchorGroup = self.baseViewModel.anchorGroups[section]
        return anchorGroup.anchors.count
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //组
        let group = self.baseViewModel.anchorGroups[indexPath.section]
        //主播
        let anchorModel = group.anchors[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalLiveCollectionViewCell
        
        cell.anchorModel = anchorModel
        
        return cell
        
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! RecommendCollectionHeaderView
        
        headerView.group = self.baseViewModel.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
}
