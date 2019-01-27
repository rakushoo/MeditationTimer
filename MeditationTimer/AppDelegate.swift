//
//  AppDelegate.swift
//  MeditationTimer
//
//  Created by shogo on 2018/06/17.
//  Copyright © 2018年 shogo kohraku. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let sectionNum: Int = 4
    let timerNum: Int = 4

    // タイマー4個分の配列
    var timerArray = [timerData(), timerData(), timerData(), timerData()]
    var currentTimerIndex: Int = 0
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

//外部変数：タイマー設定
struct sectionData {
    var minute: Int = 0
    var second: Int = 10
    var bEnabled: Bool = true
    var sectionName: String = String("セクション")
}
struct timerData {
    var section: [sectionData] = [sectionData(),
                                  sectionData(),
                                  sectionData(),
                                  sectionData()]
    var currentSectionIndex:Int = 0
    var bEnabled: Bool = true
    var timerName: String = String("タイマー")
}
