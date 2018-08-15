//
//  PrettyLiveCollectionViewCell.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/7.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class PrettyLiveCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coverImg: UIImageView!
    
    @IBOutlet weak var onlineLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var cityButton: UIButton!
    
    var anchorModel: AnchorModel? {
        
        didSet{
            
            guard let anchorModel = anchorModel else {return}
            
            var onlineStr = ""
            if anchorModel.online >= 10000 {
                onlineStr = "\(anchorModel.online / 10000)万在线"
            }else{
                onlineStr = "\(anchorModel.online)万在线"
            }
            
            self.onlineLabel.text = onlineStr
            self.nameLabel.text = anchorModel.nickname
            self.cityButton.setTitle(anchorModel.anchor_city, for: .normal)
            
            //设置封面
            guard let cover_src = anchorModel.vertical_src else {return}
            self.coverImg.kf.setImage(with: URL(string: cover_src), placeholder: UIImage(named: "live_cell_default_phone"))
            
        }
        
    }
}
