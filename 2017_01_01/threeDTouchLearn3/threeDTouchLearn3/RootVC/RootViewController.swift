//
//  RootViewController.swift
//  threeDTouchLearn3
//
//  Created by xiaoyulong on 2017/5/31.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            print("支持 3D Touch")
        } else {
            print("不支持 3D Touch")
        }
        
    }
    
   

  

}
