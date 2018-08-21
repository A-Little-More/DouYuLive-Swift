//
//  FunnyViewModel.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/13.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let FunnyURL = "http://capi.douyucdn.cn/api/v1/getColumnRoom/2"

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    
    func loadFunnyData(finishedCallback: @escaping () -> ()) {
        
        self.loadAnchorData(isGroup: false, URLStr: FunnyURL, method: .GET, finishedCallback: finishedCallback)
        
    }
    
}
