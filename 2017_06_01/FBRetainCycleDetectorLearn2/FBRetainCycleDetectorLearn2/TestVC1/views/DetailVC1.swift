//
//  DetailVC1.swift
//  FBRetainCycleDetectorLearn2
//
//  Created by xiaoyulong on 2017/4/25.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import UIKit

class DetailVC1: UIViewController {

    var nameStr: String?

    
    var completionCallBack: (() -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: UIBarButtonItemStyle.plain, target: self, action: #selector(savePerson))

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("DetailVC1 deinit...")
    }
    

    @objc fileprivate func savePerson() -> Void {
        
        completionCallBack!()
        
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
