//
//  GameViewModel.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/11.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let LoadGameURL:String = "http://capi.douyucdn.cn/api/v1/getColumnDetail"

class GameViewModel {

    lazy var games: [GameModel] = [GameModel]()
    
}

extension GameViewModel {
    
    func loadAllGameData(finishedCallback: @escaping () -> ()) {
        
        NetworkTools.requestData(urlString: LoadGameURL, menthod: .GET, parameters: ["short_name": "game"]) { (result) in
            
            guard let resultDict = result as? [String: Any] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {return}
            
            for dict in dataArray {
                
                let gameModel: GameModel = GameModel(dict: dict)
                
                self.games.append(gameModel)
                
            }
            
            finishedCallback()
            
        }
        
    }
    
}
