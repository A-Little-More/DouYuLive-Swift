//
//  NormalLiveCollectionViewCell.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/6.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit
import Kingfisher

class NormalLiveCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coverImg: UIImageView!
    
    @IBOutlet weak var onlineLabel: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchorModel: AnchorModel? {
        
        didSet{
            
            guard let anchorModel = anchorModel else {return}
            
            var onlineStr = ""
            if anchorModel.online >= 10000 {
                onlineStr = "\(anchorModel.online / 10000)万在线"
            }else{
                onlineStr = "\(anchorModel.online)万在线"
            }
            
            self.onlineLabel.setTitle(onlineStr, for: .normal)
            self.nameLabel.text = anchorModel.room_name
            self.nickNameLabel.text = anchorModel.nickname
            //设置封面
            guard let cover_src = anchorModel.vertical_src else {return}
            self.coverImg.kf.setImage(with: URL(string: cover_src), placeholder: UIImage(named: "Img_default"))
            
        }
        
    }
    
}
