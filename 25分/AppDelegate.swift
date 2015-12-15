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
    let completeCategory = "COMPLETE_CATEGORY"
    let restCategory = "REST_COMPLETE_CATEGORY"
    let timerObjectKey = "timerObjectKey"
    let timerFireDateKey = "timerFireDate"
    let timerCurrentStateKey = "timerCurrentStateKey"
    let mp3Extension = ".mp3"

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
        
        let notificationActionRest:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        notificationActionRest.identifier = "restRemindRater"
        notificationActionRest.title = "再休息一会儿"
        notificationActionRest.destructive = false
        notificationActionRest.authenticationRequired = false
        notificationActionRest.activationMode = UIUserNotificationActivationMode.Background
        
        let notificationActionWoring:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        notificationActionWoring.identifier = "workingNow"
        notificationActionWoring.title = "工作"
        notificationActionWoring.destructive = false
        notificationActionWoring.authenticationRequired = false
        notificationActionWoring.activationMode = UIUserNotificationActivationMode.Background
        
        
        //MARK: -Notification Category
        let notificationCompleteCategory: UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        notificationCompleteCategory.identifier = completeCategory
        notificationCompleteCategory.setActions([notificationActionOk,notificationActionCancel], forContext: .Default)
        notificationCompleteCategory.setActions([notificationActionOk,notificationActionCancel], forContext: .Minimal)
        
        let notificationRestCompletCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        notificationRestCompletCategory.identifier = restCategory
        notificationRestCompletCategory.setActions([notificationActionRest,notificationActionWoring], forContext: .Default)
        notificationRestCompletCategory.setActions([notificationActionRest,notificationActionWoring], forContext: .Minimal)
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Sound , .Alert , .Badge], categories: NSSet(array: [notificationCompleteCategory,notificationRestCompletCategory]) as? Set<UIUserNotificationCategory>))
        return true
    }
    
    //MARK: - handle action
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        application.applicationIconBadgeNumber = 0
        let myTimer = Timer.shareInstance
        
        if let identifier = identifier{
            switch identifier{
            case "completeRemindRater":
                let remindRaterNotification = setNotification("已再工作5分钟", timeToNotification: 5, soundName: bgmFilename.winMusic + mp3Extension, category: completeCategory)
                application.scheduleLocalNotification(remindRaterNotification)
            case "relaxNow":
                myTimer.timerCurrentState = timerState.rest
                myTimer.fireDate = NSDate(timeIntervalSinceNow: Double(myTimer.restFireTime))
                let restNotification = setNotification("时间到了，休息完毕",timeToNotification: Double(myTimer.restFireTime),soundName: bgmFilename.restFinishMusic + mp3Extension,category: "REST_COMPLETE_CATEGORY")
                playBackgroundMusic(bgmFilename.restMusic, cycle: true)
                UIApplication.sharedApplication().scheduleLocalNotification(restNotification)

            case "restRemindRater":
                let remindRaterNotification = setNotification("已再休息5分钟", timeToNotification: 5, soundName: bgmFilename.restFinishMusic + mp3Extension, category:restCategory)
                application.scheduleLocalNotification(remindRaterNotification)
            case "workingNow":
                myTimer.timerCurrentState = timerState.start
                myTimer.fireDate = NSDate(timeIntervalSinceNow: Double(myTimer.fireTime))
                let completeNotification = setNotification("时间到了，已完成任务",timeToNotification: Double(myTimer.fireTime),soundName: bgmFilename.winMusic + mp3Extension,category: "COMPLETE_CATEGORY")
                playBackgroundMusic(bgmFilename.musicFile, cycle: true)
                UIApplication.sharedApplication().scheduleLocalNotification(completeNotification)
            default:
                print("error :\(identifier)")
            }
        }
        NSUserDefaults.standardUserDefaults().setObject(myTimer.timerCurrentState, forKey: timerCurrentStateKey)
        NSUserDefaults.standardUserDefaults().setObject(myTimer.fireDate, forKey: timerFireDateKey)
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        completionHandler()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

        let timer = Timer.shareInstance
        if (timer.fireDate == nil){
            return
        }
        let restTime = timer.fireDate.timeIntervalSinceDate(NSDate(timeIntervalSinceNow: 0))
        NSUserDefaults.standardUserDefaults().setObject(timer.fireDate, forKey: timerFireDateKey)
        NSUserDefaults.standardUserDefaults().setObject(timer.timerCurrentState, forKey: timerCurrentStateKey)
        if restTime < 0 {
            return
        }
        
        //MARK: -notification
        if timer.timerCurrentState == timerState.start{
            //present notification
            let completeNotification = setNotification("时间到了，已完成任务",timeToNotification: restTime,soundName: bgmFilename.winMusic + mp3Extension,category: "COMPLETE_CATEGORY")
            UIApplication.sharedApplication().scheduleLocalNotification(completeNotification)

        }else if timer.timerCurrentState == timerState.rest{
            //present notification
            let restNotification = setNotification("时间到了，休息完毕",timeToNotification: restTime,soundName: bgmFilename.restFinishMusic + mp3Extension,category: "REST_COMPLETE_CATEGORY")
            UIApplication.sharedApplication().scheduleLocalNotification(restNotification)
            
        }else{
            print("error")
        }
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //cacel notification and bandage
   

    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        //cacel notification and bandage
        let fireDate = NSUserDefaults.standardUserDefaults().objectForKey(timerFireDateKey) as? NSDate
        let currentState = NSUserDefaults.standardUserDefaults().objectForKey(timerCurrentStateKey) as? String
        if fireDate == nil || currentState == nil{
            return
        }
        


        let timeInterval = Int((fireDate!.timeIntervalSinceDate(NSDate(timeIntervalSinceNow: 0))))
        
        if timeInterval > 0 {
            Timer.shareInstance.currentTime = timeInterval
            Timer.shareInstance.timerCurrentState = currentState!
            Timer.shareInstance.timerAction()
        }else{
            Timer.shareInstance.currentTime = 0
        }
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        NSUserDefaults.standardUserDefaults().setBool(!voice, forKey: voiceKey)
        NSUserDefaults.standardUserDefaults().setObject(Timer.shareInstance.fireDate, forKey: timerFireDateKey)
    }


}

