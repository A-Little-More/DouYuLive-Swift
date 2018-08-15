//
//  RecommendCycleCollectionCell.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/8.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class RecommendCycleCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel: CycleModel? {
        
        didSet {
            
            guard let cycleModel = cycleModel else {
                return
            }
            
            guard let pic_url = cycleModel.pic_url else {
                return
            }
            
            self.imageView.kf.setImage(with: URL(string: pic_url))
            
            self.titleLabel.text = cycleModel.title
            
        }
        
    }

}
