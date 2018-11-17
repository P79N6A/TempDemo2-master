//
//  ViewController.swift
//  SwitchImageOnScrollView
//
//  Created by FrankLiu on 15/11/10.
//  Copyright © 2015年 刘大帅. All rights reserved.
//  作者
//  https://github.com/yafoolaw
//  http://www.jianshu.com/users/09e77d340dcf/latest_articles
//


// Demo地址
//https://github.com/yafoolaw/SwitchImageOnScrollView
//http://www.jianshu.com/p/f2b342534e25


import UIKit

// MARK: -ScrollView上ImageView的位移因子
enum SwitchFactor {
    
    // 平滑过渡
    case smoothStyle
    
    // 交换过渡
    case replaceStyle
    
    // 以下皆是经验值,并非计算出来的
    func factor() -> CGFloat {
        
        switch self {
            
        case .smoothStyle:
            
            return 1
            
        case .replaceStyle:
            
            return 2
        }
    }
}

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView?
    let viewWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView?.delegate      = self
        scrollView?.isPagingEnabled = true
        
        view.addSubview(scrollView!)
        
        let imageArray = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5")]
        
        for (index, value) in imageArray.enumerated() {
            
            let show = MoreInfoView(frame: CGRect(x: CGFloat(index) * view.bounds.size.width, y: 0, width: view.bounds.width, height: view.bounds.height))
            
            show.imageView?.image = value
            
            scrollView?.addSubview(show)
        }
        
        scrollView?.contentSize = CGSize(width: CGFloat(imageArray.count) * view.bounds.width, height: view.bounds.height)
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let x = scrollView.contentOffset.x
        
        for (index, value) in scrollView.subviews.enumerated() {
            
            if value.isKind(of: MoreInfoView.classForCoder()) {
                
                let temp = value as! MoreInfoView
                
                // 乘数因子
                let factor = SwitchFactor.smoothStyle
                
                // 产生视差效果
                var rect: CGRect = (temp.imageView?.frame)!
                rect.origin.x = factor.factor() * (x - CGFloat(index) * viewWidth)
                temp.imageView?.frame = rect
            }
            
        }
    }
    
    
}

