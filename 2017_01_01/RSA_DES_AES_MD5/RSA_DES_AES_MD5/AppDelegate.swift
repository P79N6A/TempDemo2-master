//
//  AppDelegate.swift
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 17/1/17.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()

        
        // MARK: - RSA加密
//        let rootVC = TestVC4.init()
//        let nav = UINavigationController.init(rootViewController: rootVC)
//        rootVC.navigationItem.title = String.init(describing: type(of: rootVC))
//        self.window?.rootViewController = nav
        
        
        // MARK: - MD5加密
//        let rootVC = TestVC3.init()
//        let nav = UINavigationController.init(rootViewController: rootVC)
//        rootVC.navigationItem.title = String.init(describing: type(of: rootVC))
//        self.window?.rootViewController = nav
        
        
        // MARK: - AES加密
//        let rootVC = TestVC2.init()
//        let nav = UINavigationController.init(rootViewController: rootVC)
//        rootVC.navigationItem.title = String.init(describing: type(of: rootVC))
//        self.window?.rootViewController = nav
        
        
        // MARK: - DES加密
        let rootVC = TestVC1.init()
        let nav = UINavigationController.init(rootViewController: rootVC)
        rootVC.navigationItem.title = String.init(describing: type(of: rootVC))
        self.window?.rootViewController = nav
        
        
        // MARK: - DES加密 AES加密 MD5加密  RSA加密 基本特性讲解
//        let rootVC = RootViewController.init()
//        let nav = UINavigationController.init(rootViewController: rootVC)
//        rootVC.navigationItem.title = String.init(describing: type(of: rootVC))
//        self.window?.rootViewController = nav
        
        
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


}

