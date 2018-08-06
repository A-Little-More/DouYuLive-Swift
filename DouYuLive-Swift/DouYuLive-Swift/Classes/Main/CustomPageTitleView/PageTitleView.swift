//
//  PageTitleView.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/6.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
    
}

private let kScrollLineHeight: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {

    //titles存储型属性
    private var titles: [String]
    
    //当前所选label 的下标
    private var currentLabelIndex: Int = 0
    
    //设置代理属性
    weak var delegate: PageTitleViewDelegate?
    
    //懒加载titleLabels
    private lazy var titleLabels: [UILabel] = [UILabel]()
    
    //懒加载scrollView
    private lazy var scrollView: UIScrollView = {
      
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.scrollsToTop = false
        
        scrollView.bounces = false
        
        return scrollView
    }()
    
    //懒加载scrollLine
    private lazy var scrollLine: UIView = {
      
        let scrollLine = UIView()
        
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
        
    }()
    
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置UI界面
        self.setUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//扩展 PageTitleView
extension PageTitleView {
    
    private func setUI() {
        
        //添加scrollView
        self.addSubview(self.scrollView)
        
        self.scrollView.frame = self.bounds
        
        //设置titles
        self.setTitleLabels()
        
        //设置底线和滑块
        self.setBottomLineAndScrollLine()
    }
    
    private func setTitleLabels() {
        
        let labelW: CGFloat = self.frame.width / CGFloat(self.titles.count)
        let labelH: CGFloat = self.frame.height - kScrollLineHeight
        let labelY: CGFloat = 0
        
        for (index, title) in self.titles.enumerated() {
            
            //创建UILabel
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, a: 1.0)
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //将label 添加到scrollView上
            self.scrollView.addSubview(label)
            
            //将label 添加到titleLabels数组里
            self.titleLabels.append(label)
            
            //给label 添加点击事件
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGesture)
            
        }
        
    }
    
    private func setBottomLineAndScrollLine() {
        
        let bottomLine = UILabel()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 0.5, width: self.frame.width, height: 0.5)
        self.addSubview(bottomLine)
        
        guard let firstLabel = self.titleLabels.first else {return}
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2, a: 1.0)
        
        self.scrollView.addSubview(self.scrollLine)
        self.scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: self.frame.height - kScrollLineHeight, width: firstLabel.frame.width, height: kScrollLineHeight)
        
    }
    
}


//MARK: - 监听label的点击事件
extension PageTitleView {
    
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
        
        //获得当前label
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        //获得原来的label
        let oldLabel = self.titleLabels[currentLabelIndex]
        
        if(currentLabel !== oldLabel){
            
            currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2, a: 1.0)
            
            oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, a: 1.0)
            
            self.currentLabelIndex = currentLabel.tag
            
            let scrollLineX = CGFloat(currentLabelIndex) * self.scrollLine.frame.width
            
            UIView.animate(withDuration: 0.15, animations: {
                
                self.scrollLine.frame.origin.x = scrollLineX
                
            })
            
            //通知代理
            delegate?.pageTitleView(titleView: self, selectedIndex: currentLabelIndex)
            
            
        }
        
    }
    
}

extension PageTitleView {
    
    func setTitleViewWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        let sourceLabel = titleLabels[sourceIndex]
        
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        
        let moveX = moveTotalX * progress
        
        self.scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //颜色的变化范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress, a: 1.0)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress, a: 1.0)
        
        self.currentLabelIndex = targetIndex
        
    }
    
}

