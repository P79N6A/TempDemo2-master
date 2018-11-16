//
//  TestVC3.swift
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 17/2/7.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import UIKit

class TestVC3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        demo1()
        demo2()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Objective-C 中的 MD5加密写法
    func demo2() -> () {
        
        let demoVC = DemoVC3.init()
        

    }

    // MARK: - Swift中的 MD5加密写法
    func demo1() -> () {
        
//        在RSA_DES_AES_MD5-Bridging-Header.h中导入
//        #import <CommonCrypto/commonCrypto.h>
        
        
        // 测试的额
        print("swifter.tips".MD5)
        // dff88de99ff03d109de22fed4f71a273
        // DFF88DE99FF03D109DE22FED4F71A273

        
        /**
         当然，那些有强迫症的处女座读者可能不会希望在代码中沾上哪怕一点点 C 的东西，
         而更愿意面对纯纯的 Swift 代码，这样的话，也不妨重新制作 Swift 版本的轮子。
         比如对于 CommonCrypto 里的功能，已经可以在这里找到完整的 Swift 实现了，
         https://github.com/krzyzanowskim/CryptoSwift
         
         
         如果你只是需要 MD5 的话，这里也有一个实现。不过如果可能的话，暂时还是建议尽量使用现有的经过无数时间考验的 C 库。
         一方面现在 Swift 还很年轻，各种第三方库的引入和依赖机制还并不是很成熟；
         另外，使用动态库毕竟至少可以减少一些 app 尺寸，不是么？”
         
         
         */

        
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


extension String {
    var MD5: String {
        let cString = self.cString(using: String.Encoding.utf8)
        let length = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        
        let theResult = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH))
        
        CC_MD5(cString!, length, theResult);
        
        // 小写
        //        return String.init(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", theResult[0],theResult[1],theResult[2],theResult[3],theResult[4],theResult[5],theResult[6],theResult[7],theResult[8],theResult[9],theResult[10],theResult[11],theResult[12],theResult[13],theResult[14],theResult[15])
        
        // 大写
        return String.init(format: "%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", theResult[0],theResult[1],theResult[2],theResult[3],theResult[4],theResult[5],theResult[6],theResult[7],theResult[8],theResult[9],theResult[10],theResult[11],theResult[12],theResult[13],theResult[14],theResult[15])
    }
    
}
