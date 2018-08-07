//
//  RecommendViewController.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/6.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let kitemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenWidth - 3 * kitemMargin) / 2.0
private let kNormalItemH: CGFloat = kItemW * 3 / 4
private let kPrettyItemH: CGFloat = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {

    private lazy var recommendViewModel = RecommendViewModel()
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        
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

        self.view.backgroundColor = UIColor.blue
        
        self.setUI()
        
        self.requestLoadData()
        
    }

}


//MARK: - 请求数据
extension RecommendViewController {
    
    private func requestLoadData() {
        
        self.recommendViewModel.requestData()
        
    }
    
}

//MARK: - 设置UI
extension RecommendViewController {
    
    private func setUI() {
        
        self.view.addSubview(self.collectionView)
        
    }
    
}

extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 8
        }else{
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 1){
            return CGSize(width: kItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
    
}


