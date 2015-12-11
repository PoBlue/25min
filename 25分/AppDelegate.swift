//
//  AppDelegate.swift
//  25分
//
//  Created by blues on 15/12/11.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //MARK: - Notification Action
        let notificationActionOk : UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        notificationActionOk.identifier = "completeRemindRater"
        notificationActionOk.title = "再工作一会儿"
        notificationActionOk.destructive = false
        notificationActionOk.authenticationRequired = false
        notificationActionOk.activationMode = UIUserNotificationActivationMode.Background
        
        let notificationActionCancel: UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        notificationActionCancel.identifier = "relaxNow"
        notificationActionCancel.title = "休息"
        notificationActionCancel.destructive = false
        notificationActionCancel.authenticationRequired = false
        notificationActionCancel.activationMode = UIUserNotificationActivationMode.Background
        
        //MARK: -Notification Category
        let notificationCompleteCategory: UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        notificationCompleteCategory.identifier = "COMPLETE_CATEGORY"
        notificationCompleteCategory.setActions([notificationActionOk,notificationActionCancel], forContext: .Default)
        notificationCompleteCategory.setActions([notificationActionOk,notificationActionCancel], forContext: .Minimal)
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Sound , .Alert , .Badge], categories: NSSet(array: [notificationCompleteCategory]) as? Set<UIUserNotificationCategory>))
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

