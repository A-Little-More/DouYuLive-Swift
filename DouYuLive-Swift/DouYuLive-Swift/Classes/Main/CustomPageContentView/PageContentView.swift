//
//  PageContentView.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/6.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    
    func pageContentViewContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
    
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    //开始拖动的offset
    private var startOffSetX: CGFloat = 0
    
    private var childVcs: [UIViewController]
    /**
     *  为了避免造成循环引用使用weak修饰
     *  weak修饰的属性必须是可选型
     */
    private weak var parentVc: UIViewController?
    
    //是否禁止滚动的delegate
    private var isForbidScrollDelegate: Bool = false
    
    weak var delegate: PageContentViewDelegate?
    
    /**
     *  闭包中使用self 可能造成循环引用 为了避免 使用闭包的完整写法 {[weak self] in 实现代码}
     */
    private lazy var collectionView: UICollectionView = { [weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.blue
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
        
    }()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController?) {
        
        self.childVcs = childVcs
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = self.childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(self.isForbidScrollDelegate){return}
        
        //进度
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        
        let scrollViewW = scrollView.bounds.width
        
        if(currentOffsetX > self.startOffSetX){ //左滑
            
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            targetIndex = sourceIndex + 1 >= self.childVcs.count ? sourceIndex : sourceIndex + 1
            
            if(currentOffsetX - self.startOffSetX == scrollViewW){
                
                progress = 1.0
                
                targetIndex = sourceIndex
                
            }
            
        }else{ //右滑
            
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
        
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            sourceIndex = targetIndex + 1 >= self.childVcs.count ? targetIndex : targetIndex + 1
            
        }
     
        //传递代理
        self.delegate?.pageContentViewContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        print("progress: \(progress), sourceIndex: \(sourceIndex), targetIndex: \(targetIndex)")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.isForbidScrollDelegate = false
        
        self.startOffSetX = scrollView.contentOffset.x
        
    }
    
}

extension PageContentView {
    
    private func setUI() {
        
        //将所有的子控制器添加到父控制器中
        for childVc in self.childVcs {
            self.parentVc?.addChildViewController(childVc)
        }
        
        //添加UICollectionView，用于在Cell中存放控制器的View
        self.addSubview(self.collectionView)
        collectionView.frame = self.bounds
    }
    
}

extension PageContentView {
    
    func setCurrentIndex(index: Int) {
        
        //禁止代理
        self.isForbidScrollDelegate = true
        
        self.collectionView.setContentOffset(CGPoint(x: self.bounds.width * CGFloat(index), y: 0), animated: false)
        
    }
    
}

