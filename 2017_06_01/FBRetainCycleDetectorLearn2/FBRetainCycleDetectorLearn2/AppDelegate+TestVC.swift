//
//  AppDelegate+TestVC.swift
//  FBRetainCycleDetectorLearn2
//
//  Created by xiaoyulong on 2017/4/25.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {

    func setupTestRootVC() {
        let array = [
        
            
            "TestVC1",
            
            
//            http://www.alonemonkey.com/2016/05/15/fbretaincycledetector-analyse/
           
            // MARK: - https://github.com/facebook/FBRetainCycleDetector
            "RootViewController"
        
        ]
        
        makeController(arrary: array)
    }
    
    
    func makeController(arrary: [String]) {
//        let clsName = arrary[0]
        
        let clsName = arrary.reversed()[1]
        
        guard let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type else {
            return
        }
        
        let vc = cls.init()
        vc.navigationItem.title = clsName
        let nav = UINavigationController.init(rootViewController: vc)
        self.window?.rootViewController = nav
    }
}
