//
//  Bundle+Extensions.swift
//  FBRetainCycleDetectorLearn2
//
//  Created by xiaoyulong on 2017/4/25.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import Foundation

extension Bundle {

//    func namespace() -> String {
//        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
//    }
    
    // 计算型属性类似于函数（没有参数，没有返回值的函数）
    var namespace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
}
