//
//  PleasureMenuCollectionCell.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/13.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let kSingleMemuCellID = "kSingleMemuCellID"

class PleasureMenuCollectionCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups: [AnchorGroup]? {
        
        didSet {
            
            self.collectionView.reloadData()
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.collectionView.register(UINib(nibName: "RecommendGameCollectionCell", bundle: nil), forCellWithReuseIdentifier: kSingleMemuCellID)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: w(self.collectionView) / 4, height: h(self.collectionView) / 2)
        
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
}

extension PleasureMenuCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kSingleMemuCellID, for: indexPath) as! RecommendGameCollectionCell
        
        cell.group = self.groups![indexPath.row]
        
        cell.lineView.isHidden = true
        
        return cell
    }
    
}
