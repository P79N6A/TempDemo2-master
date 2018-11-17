//
//  TestVC1.swift
//  FBRetainCycleDetectorLearn2
//
//  Created by xiaoyulong on 2017/4/25.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import UIKit



class TestVC1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let detailVC = DetailVC1()
        
        
        detailVC.completionCallBack = { [weak detailVC] in
            
            detailVC?.nameStr = "xiaoyu"
            
            print("detailVC.nameStr==\(String(describing: detailVC?.nameStr))")
            
            print(self)
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        
        let detector = FBRetainCycleDetector.init()
        detector.addCandidate(self)

        
        

//        print("detector.findRetainCycles()==\(detector.findRetainCycles())")
        
//        print("retainCycles==\(retainCycles)")
        
        
//        FBRetainCycleDetector *detector = [[FBRetainCycleDetector alloc] init];
//        [detector addCandidate:john];
//        NSSet *retainCycles = [detector findRetainCycles];
//        NSLog(@"retainCycles==%@", retainCycles);

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
