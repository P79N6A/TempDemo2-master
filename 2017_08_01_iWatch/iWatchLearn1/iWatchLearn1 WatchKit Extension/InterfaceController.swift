//
//  InterfaceController.swift
//  iWatchLearn1 WatchKit Extension
//
//  Created by xiaoyulong on 2017/12/30.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import WatchKit
import Foundation


//WKInterfaceController---界面控制器  跟iOS中的视图控制器相似：用来显示、管理屏幕上的内容，并且响应用户交互
class InterfaceController: WKInterfaceController {
    
    
    @IBOutlet var countBtn: WKInterfaceButton!
    
    var counter: Counter
    
    override init() {
        counter = Counter()
    }

    //awakeWithContext 用来准备界面的显示。借助此方法用来加载数据，标签、图像数据的更新 -----viewDidload相似
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        print("awakeWithContext")
        
        // 加载上次保存的数据
        counter.load();
        countBtn.setTitle("\(counter.count)")
        
    }
    
    //willActivate 这个方法可以让你知道界面是否对用户可视，可以借助这个方法来更新界面对象 ----- viewWillAppear相似
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("willActivate")
    }
    
    //didDeactivate 界面处于非活状态, 在这个方法中我们一般用来执行一些清理任务. 注意： 在这个方法中我们不能设置界面控制器属性值的改变
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        print("didDeactivate")
    }
    

    @IBAction func countBtnClick() {
        print("countBtnClick")
        
        counter.increate()
        
        countBtn.setTitle("\(counter.count)")
        
    }
    
    
    /// 添加 Context Menu事件
    @IBAction func resetCounter() {
        
        // 重置
        print("resetCounter")
        
        counter.resetCounter()
        countBtn.setTitle("\(counter.count)")

        
        
        /*
         添加控件 WKInterfaceMenu
         3DTouch 长按 iWatch 屏幕，弹出 item。
         */
        
    }
    
    
    
    
    

}
