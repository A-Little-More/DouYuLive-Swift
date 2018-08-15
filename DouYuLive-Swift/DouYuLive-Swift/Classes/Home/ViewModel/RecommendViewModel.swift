//
//  RecommendViewModel.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/7.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let HOTCATEURL = "http://capi.douyucdn.cn/api/v1/getHotCate" //热门游戏
private let VERTICALROOMURL = "http://capi.douyucdn.cn/api/v1/getVerticalRoom" //颜值
private let BIGDATAROOM = "http://capi.douyucdn.cn/api/v1/getBigDataRoom" //推荐
private let CYCLEDATA = "http://www.douyutv.com/api/v1/slide/6" //轮播

class RecommendViewModel: BaseViewModel {

    private lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()
    
    lazy var cycleDatas: [CycleModel] = [CycleModel]()
    
}


//MARK: - 发送网络请求
extension RecommendViewModel {
    
    func requestData(finishedCallback: @escaping (() -> ())) {

        //异步请求组
        let dispatchGroup = DispatchGroup()
        
        //请求参数
        let parameters = ["limit": "4", "offset": "0", "time": NSDate.getCurrentTimeInterval()]
        
        //进入组
        dispatchGroup.enter()
        /**
         *  请求推荐直播
         *  http://capi.douyucdn.cn/api/v1/getBigDataRoom?time=1533627442.609432
         */
        NetworkTools.requestData(urlString: BIGDATAROOM, menthod: .GET, parameters: ["time": NSDate.getCurrentTimeInterval()]) { (result) in
            
            //将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else {return}
            
            //获得data下面的数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
            
            //新建一个组
            let group = AnchorGroup()
            
            group.tag_name = "热门"
            group.small_icon_url = "home_header_hot"
            
            //遍历数组
            for dic in dataArray {
                
                let anchor = AnchorModel(dict: dic)
                
                group.anchors.append(anchor)
                
            }
            
            self.bigDataGroup = group
            
            //离开组
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        /**
         *  请求颜值推荐
         *  http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1533627442.609432
         */
        NetworkTools.requestData(urlString: VERTICALROOMURL, menthod: .GET, parameters: parameters) { (result) in
            
            //将result转成字典类型
            guard let resultDic = result as? [String : Any] else {return}
            
            //获得data下面的数组
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {return}
            
            //新建一个组
            let group = AnchorGroup()
            
            group.tag_name = "颜值"
            group.small_icon_url = "home_header_phone"
            
            //遍历数组
            for dic in dataArray {
                
                let anchor = AnchorModel(dict: dic)
                
                group.anchors.append(anchor)
                
            }
            
            self.prettyGroup = group
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        /**
         *  请求后面部分游戏数据
         *  http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1533627442.609432
         */
        loadAnchorData(URLStr: HOTCATEURL, method: .GET, parameters: parameters) {
            
            dispatchGroup.leave()
            
        }
        
        //全部接口全部完成
        dispatchGroup.notify(queue: .main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishedCallback()
        }
        
    }
    
    //请求无限轮播
    func requestCycleData(finishedCallback: @escaping ()-> ()) {
        
        NetworkTools.requestData(urlString: CYCLEDATA, menthod: .GET, parameters: ["version" : "2.300"]) { (result) in
            
            //将result转成字典类型
            guard let resultDic = result as? [String : Any] else {return}
            
            //获得data下面的数组
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {return}
            
            for cycle in dataArray {
                
                let cycleModel = CycleModel(dict: cycle)
                
                self.cycleDatas.append(cycleModel)
                
            }
            
            finishedCallback()
            
        }
        
    }
    
}
