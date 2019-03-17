//
//  AppDelegate.swift
//  MeditationTimer
//
//  Created by shogo on 2018/06/17.
//  Copyright © 2018年 shogo kohraku. All rights reserved.
//

import UIKit


//瞑想中の音
enum SectionSound {
    case Sea
    case Stream
    case Cloud
    case Forest
}
//瞑想終了時のアラーム
enum SectionAlerm {
    case TempleBlock
    case Chime
    case Marimba
    case Triangle
}

//外部変数：タイマー設定
struct sectionData {
    var minute: Int = 0
    var second: Int = 0
    var sound: SectionSound = SectionSound.Sea
    var alerm: SectionAlerm = SectionAlerm.TempleBlock
    var bEnabled: Bool = false
    var sectionName: String = String("セクション")
    
}
struct timerData {
    let sectionNum: Int = 3
    var section: [sectionData] = [sectionData(), sectionData(), sectionData()]
    var currentSectionIndex:Int = 0
    var bEnabled: Bool = true
    var patternName: String = String("パターン")
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let timerNum: Int = 3

    // タイマー4個分の配列、暫定で4固定
    var timerArray = [timerData(), timerData(), timerData()]
    var currentTimerIndex: Int = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        //起動時の初期化
        timerArray[0].patternName = String(format: "3分瞑想")

        timerArray[0].section[0].bEnabled = true
        timerArray[0].section[0].minute = 1
        timerArray[0].section[0].second = 30
        timerArray[0].section[0].sound = SectionSound.Sea
        timerArray[0].section[0].sectionName = String("セクション1")
        
        timerArray[0].section[1].bEnabled = true
        timerArray[0].section[1].minute = 1
        timerArray[0].section[1].second = 30
        timerArray[0].section[1].sound = SectionSound.Forest
        timerArray[0].section[1].sectionName = String("セクション2")

        timerArray[1].patternName = String(format: "6分瞑想")
        timerArray[1].section[0].bEnabled = true
        timerArray[1].section[0].minute = 2
        timerArray[1].section[0].sound = SectionSound.Forest
        timerArray[1].section[0].sectionName = String("セクション1")

        timerArray[1].section[1].bEnabled = true
        timerArray[1].section[1].minute = 4
        timerArray[1].section[1].sectionName = String("セクション2")

        timerArray[2].patternName = String(format: "9分瞑想")
        timerArray[2].section[0].bEnabled = true
        timerArray[2].section[0].minute = 1
        timerArray[2].section[0].sound = SectionSound.Sea
        timerArray[2].section[0].sectionName = String("セクション1")

        timerArray[2].section[1].bEnabled = true
        timerArray[2].section[1].minute = 4
        timerArray[2].section[1].sectionName = String("セクション2")

        timerArray[2].section[2].bEnabled = true
        timerArray[2].section[2].minute = 4
        timerArray[2].section[2].sectionName = String("セクション3")

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


