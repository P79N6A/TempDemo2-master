//
//  RootViewController.swift
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 17/1/17.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /**
         
         网络安全之数据加密（DES、AES、RSA、MD5）
         http://www.jianshu.com/p/98569e81cc0b
         https://github.com/watermin
         
         
         iOS，一行代码进行RSA、DES 、AES加密、解密及MD5加密
         http://www.jianshu.com/p/8fd8306a95d0
         https://github.com/Flying-Einstein/Encryptions
         
         */
     
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - MD5
    // MARK: 是一种校验方式，用于保证文件的正确性，防止被植入木马或病毒。
    // MARK: MD5功能：输入任意长度的信息，经过处理，输出为128位的信息（数字指纹）；不同的输入得到的不同的结果（唯一性）；根据128位的输出结果不可能反推出输入的信息（不可逆）。
    func demo4() -> () {
        
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
        
        
        /**
         MD5（单向散列算法）的全称是Message-Digest Algorithm 5（信息-摘要算法），经MD2、MD3和MD4发展而来。MD5算法的使用不需要支付任何版权费用。
         MD5功能：输入任意长度的信息，经过处理，输出为128位的信息（数字指纹）；不同的输入得到的不同的结果（唯一性）；根据128位的输出结果不可能反推出输入的信息（不可逆）。
         MD5用途：
         a，防止被篡改：1）比如发送一个电子文档，发送前，我先得到MD5的输出结果a。然后在对方收到电子文档后，对方也得到一个MD5的输出结果b。如果a与b一样就代表中途未被篡改。2）比如我提供文件下载，为了防止不法分子在安装程序中添加木马，我可以在网站上公布由安装文件得到的MD5输出结果。3）SVN在检测文件是否在CheckOut后被修改过，也是用到了MD5.
         b，防止直接看到明文：现在很多网站在数据库存储用户的密码的时候都是存储用户密码的MD5值。这样就算不法分子得到数据库的用户密码的MD5值，也无法知道用户的密码。当用户登录的时候，系统把用户输入的密码计算成MD5值，然后再去和保存在文件系统中的MD5值进行比较，进而确定输入的密码是否正确。通过这样的步骤，系统在并不知道用户密码的明码的情况下就可以确定用户登录系统的合法性。
         无论在Android上还是pc上用Java实现MD5都比较容易，因为java已经把它做到了java.security.MessageDigest里。下面是一个MD5Util.java类的使用
         */
        
    }
    
    // MARK: - AES
    // MARK: 对称加密算法
    func demo3() -> () {
        
        /**
         
         高级加密标准（英语：Advanced Encryption Standard，缩写：AES），
         在密码学中又称Rijndael加密法，
         是美国联邦政府采用的一种区块加密标准。
         这个标准用来替代原先的DES，已经被多方分析且广为全世界所使用。
         经过五年的甄选流程，高级加密标准由美国国家标准与技术研究院（NIST）于2001年11月26日发布于FIPS PUB 197，并在2002年5月26日成为有效的标准。
         2006年，高级加密标准已然成为对称密钥加密中最流行的算法之一。
         
         */
        
    }
    
    
    // MARK: - DES
    // MARK: 对称加密算法，指加密和解密使用相同密钥的加密算法
    func demo2() -> () {
        
        /**
         des对称加密，是一种对称加密算法。
         
         在对称加密算法中，数据发信方将明文（原始数据）和加密密钥（mi yao）一起经过特殊加密算法处理后，使其变成复杂的加密密文发送出去。
         收信方收到密文后，若想解读原文，则需要使用加密用过的密钥及相同算法的逆算法对密文进行解密，才能使其恢复成可读明文。
         在对称加密算法中，使用的密钥只有一个，发收信双方都使用这个密钥对数据进行加密和解密，这就要求解密方事先必须知道加密密钥。
         */
        
        
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
    }
    
    
    // MARK: - RSA
    // MARK: 非对称加密算法，公钥和私钥不一致
    func demo1() -> () {
        
        /**
         RSA公钥加密算法是1977年由
         罗纳德·李维斯特（Ron Rivest）、
         阿迪·萨莫尔（Adi Shamir）和
         伦纳德·阿德曼（Leonard Adleman）一起提出的。
         
         1987年首次公布，当时他们三人都在麻省理工学院工作。
         RSA就是他们三人姓氏开头字母拼在一起组成的。
         
         RSA是目前最有影响力的公钥加密算法，它能够抵抗到目前为止已知的绝大多数密码攻击，
         已被ISO推荐为公钥数据加密标准。
         */
        
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
