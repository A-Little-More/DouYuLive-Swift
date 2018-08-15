//
//  HomeViewController.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/5.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let kTitleViewHeight: CGFloat = 40

class HomeViewController: UIViewController {

    // MARK: - 懒加载pageTitleView属性
    private lazy var pageTitleView: PageTitleView = { [weak self] in
        
        let titleFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight, width: kScreenWidth, height: kTitleViewHeight)
        
        let titles = ["推荐","游戏","娱乐","趣玩"]
        
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        
        titleView.delegate = self
        
        return titleView
        
    }()
    
    // MARK: - 懒加载pageContentView属性
    /**
     *  HomeViewController在此时引用了PageContentView
     *  PageContentView也引用了self(HomeViewController)
     *  此时就会造成循环引用，为了避免循环引用 使用weak关键字
     */
    private lazy var pageContentView: PageContentView = { [weak self] in
      
        var childVcs = [UIViewController]()
        //添加推荐控制器
        childVcs.append(RecommendViewController())
        //添加游戏控制器
        childVcs.append(GameViewController())
        //添加娱乐控制器
        childVcs.append(PleasureViewController())
        //添加趣玩控制器
        childVcs.append(FunnyViewController())
        
        let contentViewFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight + kTitleViewHeight, width: kScreenWidth, height: kScreenHeight - (kStatusBarHeight + kNavigationBarHeight + kTitleViewHeight + kTabBarHeight))
        
        let contentView = PageContentView(frame: contentViewFrame, childVcs: childVcs, parentVc: self)
        
        contentView.delegate = self
        
        return contentView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUI()
        
    }

}

// MARK: - 设置UI界面
extension HomeViewController {
    
    private func setUI() {
        
        //不需要调整UIScrollView的内边距
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.setLeftNavigationBar()
        
        self.setRightNavigationBar()
        
        self.view.addSubview(pageTitleView)
        
        self.view.addSubview(pageContentView)
        
    }
    
    /**
     *  设置左边的navigationBar
     */
    private func setLeftNavigationBar() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
    }
    
    /**
     *  设置右边的navigationBar
     */
    private func setRightNavigationBar() {
        
        let normalImages: [String] = ["image_my_history","btn_search","Image_scan"]
        
        let selectedImages: [String] = ["Image_my_history_click","btn_search_clicked","Image_scan_click"]
        
        var BarButtonItems: [UIBarButtonItem] = []
        
        for i in 0..<normalImages.count {
            
            let barButtonItem = UIBarButtonItem(imageName: normalImages[i], highlightImageName: selectedImages[i], size: CGSize(width: 35, height: 35))
            
            BarButtonItems.append(barButtonItem)
        }
        
        self.navigationItem.rightBarButtonItems = BarButtonItems
        
    }
    
}

//MARK: - 遵守PageTitleViewDelegate协议
extension HomeViewController: PageTitleViewDelegate {
    
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        
        self.pageContentView.setCurrentIndex(index: index)
        
    }
    
}

extension HomeViewController: PageContentViewDelegate {
    
    func pageContentViewContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        self.pageTitleView.setTitleViewWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}

