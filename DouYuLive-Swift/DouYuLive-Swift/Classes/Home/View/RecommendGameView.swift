//
//  RecommendGameView.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/9.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class RecommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var type: Int = 0
    
    //所有关于游戏的组信息
    var groups: [AnchorGroup]? {
        
        didSet {
            
            self.type = 0
            self.collectionView.reloadData()
            
        }
        
    }
    
    var gameModels: [GameModel]? {
        
        didSet {
            
            self.type = 1
            self.collectionView.reloadData()
            
        }
        
    }
    
    override func awakeFromNib() {
        
        self.autoresizingMask = []
        
    }

    override func layoutSubviews() {
        
        self.collectionView.register(UINib(nibName: "RecommendGameCollectionCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)

        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
    }
    
}

//MARK: - 初始化的类方法
extension RecommendGameView {
    
    static func recommendGameView() -> RecommendGameView{
        
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
        
    }
    
}

//MARK: - 继承collectionView的dataSource
extension RecommendGameView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.type == 0){
            return self.groups?.count ?? 0
        }else{
            return self.gameModels?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! RecommendGameCollectionCell
        
        if self.type == 0 {
            cell.group = self.groups?[indexPath.row]
        }else{
            cell.gameModel = self.gameModels?[indexPath.row]
        }
        
        return cell
    }
    
}

