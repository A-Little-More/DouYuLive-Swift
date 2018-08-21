//
//  PleasureViewModel.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/12.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let LoadPleasureUrl:String = "http://capi.douyucdn.cn/api/v1/getHotRoom/2"

class PleasureViewModel: BaseViewModel {

    
}

extension PleasureViewModel {
    
    func loadAllPleasureData(finishedCallback: @escaping () -> ()) {
        
        loadAnchorData(isGroup: true, URLStr: LoadPleasureUrl, method: .GET, finishedCallback: finishedCallback)
        
    }
    
}
