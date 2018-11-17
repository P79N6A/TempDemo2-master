//
//  InterfaceController.swift
//  iWatchLearn2 WatchKit Extension
//
//  Created by xiaoyulong on 2017/12/30.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    // WKInterfaceObject 界面对象
    // WKInterfaceLabel 标签对象
    @IBOutlet var label: WKInterfaceLabel!
    @IBOutlet var imageView: WKInterfaceImage!
    
    var index:Int = 0

    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        /*
         label 的 frame 默认靠左，靠上。
         没有那么复杂；
         */
 
 
        
    
        label.setText("Configure interface objects hereConfigure interface objects hereConfigure interface objects here Configure interface objects here")
//        label.sizeToFitWidth()
//        label.sizeToFitHeight()
        
        label.setTextColor(UIColor.yellow)
        

        //设置文本的属性   例子： 凸版印刷体效果
        
        let font = UIFont.preferredFont(forTextStyle: .headline)
        let textColor = UIColor.red
//        let attributes = [
//            NSForegroundColorAttributeName: textColor,
//            NSFontAttributeName: font,
//            NSTextEffectAttributeName: NSTextEffectLetterpressStyle
//            ] as [NSAttributedStringKey : Any]
        
        let attributes = [
            NSAttributedStringKey.foregroundColor: textColor,
            NSAttributedStringKey.font: font,
            NSAttributedStringKey.textEffect: NSAttributedString.TextEffectStyle.letterpressStyle
            ] as [NSAttributedStringKey : Any]

        
        
        var attributeStr = NSAttributedString(string: "wxhl", attributes: attributes)
        label.setAttributedText(attributeStr)
        
        
//        imageTest1()
//        imageTest2()
//        imagesTest3()
        
        
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    

    // MARK: - 通过定时器设置动画
    fileprivate func imagesTest3() {
        
        //通过定时器  设定动画
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(animationAction), userInfo: nil, repeats: true)
        
    }
    
    @objc func animationAction(timer: Timer) {
        imageView.setImageNamed("glance-\(index)")
        index = index + 1
        if index > 44 {
            timer.invalidate()
        }
    }
    
    // MARK: - 自带动画
    // 图片的TargetMembership要勾选.png
    fileprivate func imageTest2() {
        
        //设置图片  -> 通过多张图片构建一个新的动画图片
        
//        var imgs = NSMutableArray(capacity: 44)
        var imgs: [UIImage] = [UIImage]()
        
        for index in 0...44 {
            let imgName = "glance-\(index)"
            
            if let image = UIImage.init(named: imgName) {
//                imgs.add(UIImage(named: imgName))
                imgs.append(image)
            }
        }
        print("imgs.count==\(imgs.count)");
        let img = UIImage.animatedImage(with: imgs, duration: 2)
        imageView.setImage(img)
     
        
        
//        imageView.startAnimating()
        
        //通过设置动画的范围 设置图片动画
        imageView.startAnimatingWithImages(in: NSRange.init(location: 0, length: 22), duration: 2, repeatCount: -1)
    }
    
    
    // MARK: - 设置图片
    fileprivate func imageTest1() {
        imageView.setImage(UIImage.init(named: "ic_launcher"))
        
        //        let path: String = Bundle.main.path(forResource: "ic_launcher", ofType: "png") ?? ""
        //        let data: Data? = try? Data(contentsOf: URL.init(fileURLWithPath: path))
        //        imageView.setImageData(data)
        
        // 只会在 iWatchLearn2 WatchKit App 找图片
        // 最好用这个，它快一些；上面两个方法会找到图片后将资源添加到 target 中；
        //最好使用这个方法 因为上面两个方法需要将图片资源添加到App的target中，会造成延时
        //        imageView.setImageNamed("ic_launcher")
    }
    

}
