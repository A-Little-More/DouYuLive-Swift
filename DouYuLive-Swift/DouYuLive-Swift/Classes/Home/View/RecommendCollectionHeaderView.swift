//
//  RecommendCollectionHeaderView.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/6.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class RecommendCollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var headerImg: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    var group: AnchorGroup? {
        
        didSet {
            
            guard let group = group else {return}
            
            titleLabel.text = group.tag_name
            
            guard let iconUrl = group.small_icon_url else {
                headerImg.image = UIImage(named: "home_header_normal")
                return
            }
            
            guard iconUrl.contains("http") else {
                headerImg.image = UIImage(named: iconUrl)
                return
            }
            
            self.headerImg.kf.setImage(with: URL(string: iconUrl), placeholder: UIImage(named: "home_header_normal"))
        }
        
    }
    
}

extension RecommendCollectionHeaderView {
    
    static func collectionHeaderView() -> RecommendCollectionHeaderView {
        
        return Bundle.main.loadNibNamed("RecommendCollectionHeaderView", owner: nil, options: nil)?.first as! RecommendCollectionHeaderView
        
    }
    
}
