//
//  TestVC1.swift
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 17/2/7.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import UIKit

class TestVC1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        demo1()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func demo1() -> () {
        
        let demoVC = DemoVC1.init()
        self.navigationController?.pushViewController(demoVC, animated: true)
        
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


/*
 
 // MARK: - MD5
 // MARK: 是一种校验方式，用于保证文件的正确性，防止被植入木马或病毒。
 // MARK: MD5功能：输入任意长度的信息，经过处理，输出为128位的信息（数字指纹）；不同的输入得到的不同的结果（唯一性）；根据128位的输出结果不可能反推出输入的信息（不可逆）。
 
 /**
 
 MD5 即 Message-Digest Algorithm 5（信息-摘要算法5），
 用于确保信息传输完整一致。是计算机广泛使用的杂凑算法之一（又译摘要算法、哈希算法），
 主流编程语言普遍已有MD5实现。
 将数据（如汉字）运算为另一固定长度值，是杂凑算法的基础原理，MD5的前身有MD2、MD3和MD4。
 
 MD5算法具有以下特点：
 1、压缩性：任意长度的数据，算出的MD5值长度都是固定的。
 2、容易计算：从原数据计算出MD5值很容易。
 3、抗修改性：对原数据进行任何改动，哪怕只修改1个字节，所得到的MD5值都有很大区别。
 4、强抗碰撞：已知原数据和其MD5值，想找到一个具有相同MD5值的数据（即伪造数据）是非常困难的。
 
 MD5的作用是让大容量信息在用数字签名软件签署私人密钥前被"压缩"成一种保密的格式（就是把一个任意长度的字节串变换成一定长的十六进制数字串）。除了MD5以外，其中比较有名的还有sha-1、RIPEMD以及Haval等。
 */

 
 
 
 
 
 // MARK: - AES
 // MARK: 对称加密算法
 /**
 
 高级加密标准（英语：Advanced Encryption Standard，缩写：AES），
 在密码学中又称Rijndael加密法，
 是美国联邦政府采用的一种区块加密标准。
 这个标准用来替代原先的DES，已经被多方分析且广为全世界所使用。
 经过五年的甄选流程，高级加密标准由美国国家标准与技术研究院（NIST）于2001年11月26日发布于FIPS PUB 197，并在2002年5月26日成为有效的标准。
 2006年，高级加密标准已然成为对称密钥加密中最流行的算法之一。
 
 */

 
 
 
 // MARK: - DES
 // MARK: 对称加密算法，指加密和解密使用相同密钥的加密算法
 /**
 对称加密算法的特点是算法公开、计算量小、加密速度快、加密效率高。
 不足之处是，交易双方都使用同样钥匙，安全性得不到保证。
 此外，每对用户每次使用对称加密算法时，都需要使用其他人不知道的惟一钥匙，
 这会使得发收信双方所拥有的钥匙数量呈几何级数增长，密钥管理成为用户的负担。
 对称加密算法在分布式网络系统上使用较为困难，主要是因为密钥管理困难，使用成本较高。
 而与公开密钥加密算法比起来，对称加密算法能够提供加密和认证却缺乏了签名功能，
 使得使用范围有所缩小。在计算机专网系统中广泛使用的对称加密算法有DES和IDEA等。
 美国国家标准局倡导的AES即将作为新标准取代DES。
 
 
 基于“对称密钥”的加密算法主要有DES、TripleDES、RC2、RC4、RC5和Blowfish等。
 */

 
 
 
 
 // MARK: - RSA
 // MARK: 非对称加密算法，公钥和私钥不一致
 /**
 
 由于进行的都是大数计算，使得RSA最快的情况也比DES慢上好几倍，
 无论是软件还是硬件实现。速度一直是RSA的缺陷。
 一般来说只用于少量数据加密。RSA的速度比对应同样安全级别的对称密码算法要慢1000倍左右。
 
 比起DES和其它对称算法来说，RSA要慢得多。
 实际上Bob一般使用一种对称算法来加密他的信息，然后用RSA来加密他的比较短的对称密码，
 然后将用RSA加密的对称密码和用对称算法加密的消息送给Alice。
 
 这样一来对随机数的要求就更高了，尤其对产生对称密码的要求非常高，
 因为否则的话可以越过RSA来直接攻击对称密码。
 */

 
 
 
 */


