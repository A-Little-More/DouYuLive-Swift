//
//  GameViewController.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/11.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let kEdgeMargin: CGFloat = 10
private let kGameItemW: CGFloat = (kScreenWidth - 2 * kEdgeMargin) / 3
private let kGameItemH: CGFloat = kGameItemW * 6 / 5
private let kHeaderViewH: CGFloat = 50
private let kGameViewH: CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kGameHeaderViewID = "kGameHeaderViewID"

class GameViewController: UIViewController {

    private lazy var gameViewModel:GameViewModel = GameViewModel()
    
    private lazy var collectionHeaderView: RecommendCollectionHeaderView = {
        
        let collectionHeaderView = RecommendCollectionHeaderView.collectionHeaderView()
        collectionHeaderView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenWidth, height: kHeaderViewH)
        collectionHeaderView.titleLabel.text = "分类"
        collectionHeaderView.headerImg.image = UIImage(named: "Img_orange")
        collectionHeaderView.moreBtn.isHidden = true
        return collectionHeaderView
    }()
    
    private lazy var gameView: RecommendGameView = {
        
        let gameView = RecommendGameView.recommendGameView()
        
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
        
        return gameView
        
    }()
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: kGameItemW, height: kGameItemH)
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        /**
         *  设置此属性 使得随着父视图的变化而变化（宽，高）
         */
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(UINib(nibName: "RecommendGameCollectionCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        collectionView.register(UINib(nibName: "RecommendCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeaderViewID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setUI()
        
        self.loadGameData()
    }


}

extension GameViewController {
    
    private func setUI() {
        
        self.view.addSubview(self.collectionView)
        
        self.collectionView.addSubview(self.collectionHeaderView)
        
        self.collectionView.addSubview(self.gameView)
        
        self.collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
    }
    
}

extension GameViewController {
    
    private func loadGameData() {
        
        self.gameViewModel.loadAllGameData { [unowned self] in
            
            self.collectionView.reloadData()
            
//            var gameModes = [GameModel]()
//
//            if self.gameViewModel.games.count >= 10{
//
//                for i in 0..<10 {
//
//                    gameModes.append(self.gameViewModel.games[i])
//
//                }
//
//            }
//
//            self.gameView.gameModels = gameModes
            
            self.gameView.gameModels = Array(self.gameViewModel.games[0..<10])
            
            
        }
        
    }
    
}

//MARK: - 实现collectionView的代理协议
extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gameViewModel.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! RecommendGameCollectionCell
        cell.gameModel = self.gameViewModel.games[indexPath.row]
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeaderViewID, for: indexPath) as! RecommendCollectionHeaderView
        headerView.titleLabel.text = "全部"
        headerView.headerImg.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
    
    
}
