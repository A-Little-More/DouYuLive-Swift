//
//  RecommendCycleView.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/8.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleTimer: Timer?
    
    //轮播数组
    var cycleDatas: [CycleModel]? {
        
        didSet {
            
            self.collectionView.reloadData()
            
            //设置pageControl
            self.pageControl.numberOfPages = cycleDatas?.count ?? 0
            
            //初始化collectionView的contentOffset
            let startIndexPath = IndexPath(row: (cycleDatas?.count ?? 0) * 100, section: 0)
            self.collectionView.scrollToItem(at: startIndexPath, at: .left, animated: false)
            
            self.removeCycleTimer()
            self.addCycleTimer()
            
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置该控件不随着父控件的拉伸而拉伸
        self.autoresizingMask = []
        
        self.collectionView.register(UINib(nibName: "RecommendCycleCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
    }
    
    override func layoutSubviews() {
        
        /**
         *  放在layoutSubviews方法里，可以获得到准确的self的frame
         */
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: w(self), height: h(self))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.isPagingEnabled = true
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        
    }

}

//MARK: - 定义类方法初始化
extension RecommendCycleView {
    
    static func recommendCycleView() -> RecommendCycleView {
    
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    
    }
    
}

//MARK: - 实现UICollectionViewDataSource
extension RecommendCycleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.cycleDatas?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! RecommendCycleCollectionCell
        
        let cycleModel = self.cycleDatas?[indexPath.row % (self.cycleDatas?.count ?? 1)]
        
        cell.cycleModel = cycleModel
        
        return cell
        
    }
    
}

extension RecommendCycleView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + w(scrollView) * 0.5

        self.pageControl.currentPage = Int(offsetX / w(scrollView)) % (self.cycleDatas?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addCycleTimer()
    }
    
}

//MARK:- 定时器控制
extension RecommendCycleView {
    
    private func addCycleTimer() {
        
        self.cycleTimer = Timer(fireAt: Date(timeIntervalSinceNow: 3.0), interval: 3.0, target: self, selector: #selector(cycleTimerAction), userInfo: nil, repeats: true)
        
        RunLoop.main.add(self.cycleTimer!, forMode: .commonModes)
    }
    
    private func removeCycleTimer() {
        
        self.cycleTimer?.invalidate()
        self.cycleTimer = nil
        
    }
    
    @objc private func cycleTimerAction() {
        let currentOffsetX = self.collectionView.contentOffset.x
        let offsetX = currentOffsetX + w(self.collectionView)
        
        self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
}

