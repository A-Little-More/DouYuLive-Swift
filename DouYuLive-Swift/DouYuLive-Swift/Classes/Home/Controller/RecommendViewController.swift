//
//  RecommendViewController.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/6.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let kCycleViewH: CGFloat = kScreenWidth * 3 / 8
private let kGameViewH: CGFloat = 90

class RecommendViewController: BaseAnchorViewController {

    //无限轮播
    private lazy var cycleView: RecommendCycleView = {
        
        let cycleView = RecommendCycleView.recommendCycleView()
        
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenWidth, height: kCycleViewH)
        
        return cycleView
    }()
    
    private lazy var gameView: RecommendGameView = {
        
        let gameView = RecommendGameView.recommendGameView()
        
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
        
        return gameView
        
    }()
    
    //懒加载viewModel
    private lazy var recommendViewModel = RecommendViewModel()
    

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.setUI()
//
//        self.requestLoadData()
//
//    }

}


//MARK: - 请求数据
extension RecommendViewController {
    
    override func requestLoadData() {
        
        //给父视图的viewModel赋值
        self.baseViewModel = self.recommendViewModel
        
        //请求推荐数据
        self.recommendViewModel.requestData { [weak self] in
            self?.collectionView.reloadData()
            
            var gameGroups = self?.recommendViewModel.anchorGroups
            
            gameGroups?.remove(at: 0)
            gameGroups?.remove(at: 0)
            
            let moreGameGroup = AnchorGroup()
            moreGameGroup.tag_name = "更多"
            
            gameGroups?.append(moreGameGroup)
            self?.gameView.groups = gameGroups
            
            //请求完数据，结束动画
            self?.loadDataFinished()
            
        }
        
        //请求无限轮播
        self.recommendViewModel.requestCycleData { [weak self] in
            
            self?.cycleView.cycleDatas = self?.recommendViewModel.cycleDatas
            
        }
        
    }
    
}

//MARK: - 设置UI
extension RecommendViewController {
    
    override func setUI() {
        
        super.setUI()
        
//        self.view.addSubview(self.collectionView)
     
        self.collectionView.addSubview(self.cycleView)
        
        self.collectionView.addSubview(self.gameView)
        
        //设置collectionView的内边距,目的让轮播图显示出来
        self.collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
    
}

extension RecommendViewController {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //组
        let group = self.baseViewModel.anchorGroups[indexPath.section]
        //主播
        let anchorModel = group.anchors[indexPath.row]
        if(indexPath.section == 1){

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! PrettyLiveCollectionViewCell
            cell.anchorModel = anchorModel
            return cell

        }else{

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalLiveCollectionViewCell
            cell.anchorModel = anchorModel
            return cell

        }

    }


    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 1){
            return CGSize(width: kItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }

}


