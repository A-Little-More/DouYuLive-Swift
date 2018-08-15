//
//  RecommendGameCollectionCell.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/9.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class RecommendGameCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    
    var group: AnchorGroup? {
        
        didSet {
            
            self.lineView.isHidden = true
            
            guard let group = group else {return}
            
            self.nameLabel.text = group.tag_name!
            
            if(group.tag_name! == "更多"){
                
                self.imageView.image = UIImage(named: "home_more_btn")
                
            }else{
                
                self.imageView.kf.setImage(with: URL(string: group.icon_url!), placeholder: UIImage(named: "live_cell_default_phone"))
                
            }
 
        }
        
    }
    
    var gameModel: GameModel? {
        
        didSet {
            
            self.lineView.isHidden = false
            
            guard let gameModel = gameModel else { return }
            
            self.nameLabel.text = gameModel.tag_name
            
            if let icon_url = gameModel.icon_url {
                
                self.imageView.kf.setImage(with: URL(string: icon_url), placeholder: UIImage(named: "live_cell_default_phone"))
                
            }else{
                
                self.imageView.image = UIImage(named: "live_cell_default_phone")
                
            }
            
        }
        
    }

}
