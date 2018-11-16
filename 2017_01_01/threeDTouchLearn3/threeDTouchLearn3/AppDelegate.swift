//
//  AppDelegate.swift
//  threeDTouchLearn3
//
//  Created by xiaoyulong on 2017/5/31.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    enum ShortcutIdentifier: String {
        case First
        case Second
        case Third
        
        init?(fullType: String) {
            guard let last = fullType.components(separatedBy: ".").last else {
                return nil
            }
            
            self.init(rawValue: last)
        }
        
        var type: String {
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    var window: UIWindow?
    
    fileprivate  var rootNav: UINavigationController?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()

        let root = RootViewController()
        root.navigationItem.title = "RootViewController"
        rootNav = UINavigationController.init(rootViewController: root)
        window?.rootViewController = rootNav
        
        
        if root.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            print("支持 3D Touch")
        } else {
            print("不支持 3D Touch")
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        let dict = shortcutItem.userInfo
        print("dict==\(dict ?? [:])")
        
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)

    }
    
    
    
    fileprivate func handleShortCutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        
        var handled = false
        
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
        
        guard let shortCutType = shortcutItem.type as String? else {
            return false
        }
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var vc = UIViewController()

        
        switch (shortCutType) {
        case ShortcutIdentifier.First.type:
            // Handle shortcut 1
//            vc = storyboard.instantiateViewController(withIdentifier: "RunVC") as! RunViewController
            
            let controller = UIViewController()
            controller.navigationItem.title = "跳转First";
            rootNav?.pushViewController(controller, animated: true)
            
            handled = true
            break
        case ShortcutIdentifier.Second.type:
            // Handle shortcut 2
//            vc = storyboard.instantiateViewController(withIdentifier: "ScanVC") as! ScanViewController
            
            let controller = UIViewController()
            controller.navigationItem.title = "跳转Second";
            rootNav?.pushViewController(controller, animated: true)
            
            handled = true
            break
        case ShortcutIdentifier.Third.type:
            // Handle shortcut 3
//            vc = storyboard.instantiateViewController(withIdentifier: "WiFiVC") as! SwitchWiFiViewController
            let arr = [Any]()
            let vc = UIActivityViewController.init(activityItems: arr, applicationActivities:nil)
            
            
            // 如果弹出的是英文的，在 plist文件的， Localization native development region修改为 China
            //设置当前的VC 为rootVC
            window?.rootViewController?.present(vc, animated: true, completion: {
            })
            
            handled = true
            break
        default:
            break
        }
        
        // Display the selected view controller
//        window!.rootViewController?.present(vc, animated: true, completion: nil)
        
        return handled
        
    }

    
}

