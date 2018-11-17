//
//  Counter.swift
//  iWatchLearn1 WatchKit Extension
//
//  Created by xiaoyulong on 2017/12/30.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import UIKit

struct Counter {
    
    let COUNT_KEY = "COUNT_KEY"

    
    
    /// 统计点击的次数
    var count: Int = 0
 
    
    /// 点击此处加1
    mutating func increate() {
        count = count + 1
        
        save()
    }
    
    
    /// 数据保存到本地
    fileprivate func save() {
        UserDefaults.standard.set(count, forKey: COUNT_KEY);
        UserDefaults.standard.synchronize()
    }
    
    /// 读取数据
    mutating func load() {
        count = UserDefaults.standard.value(forKey: COUNT_KEY) as? Int ?? 0
    }
    
    
    mutating func resetCounter() {
        count = 0;
        save()
    }
    
}
