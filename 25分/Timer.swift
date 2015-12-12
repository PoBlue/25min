//
//  Timer.swift
//  25分
//
//  Created by blues on 15/12/12.
//  Copyright © 2015年 blues. All rights reserved.
//

import Foundation
import UIKit

class Timer : NSObject{
    
    var timerCurrentState = timerState.start
    let fireTime = 9
    let restFireTime = 6
    var currentTime = 60 * 25
    var time:NSTimer!
    var timerWillState = timerState.start
    
    
    
    func timerWillAction(completeHandler:((timerWillState:String) -> Void)?) {
        if timerWillState == timerState.updating{
            completeHandler?(timerWillState: timerState.updating)
        }
        else if  timerWillState == timerState.start {
            currentTime = fireTime
            //set timer
            self.time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeUp:", userInfo: nil, repeats: true)
            
            
            completeHandler?(timerWillState: timerState.giveUp)
//            timerButton.setTitle(timerState.giveUp, forState: .Normal)
            timerWillState = timerState.giveUp
        }else if timerWillState == timerState.giveUp{
            
            time.invalidate()
            completeHandler?(timerWillState: timerState.start)
//            timerLabel.text = formatToDisplayTime(fireTime)
//            timerButton.setTitle(timerState.start, forState: .Normal)
            timerWillState = timerState.start
            
        }else if timerWillState == timerState.rest{
            //set timer
            currentTime = restFireTime
            self.time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeUp:", userInfo: nil, repeats: true)
            
            completeHandler?(timerWillState: timerState.giveUp)
//            timerButton.setTitle(timerState.giveUp, forState: .Normal)
            timerWillState = timerState.giveUp
        }else if timerWillState == timerState.workingComplete{
            completeHandler?(timerWillState: timerState.workingComplete)
//            timerButton.setTitle(timerState.workingComplete, forState: .Normal)
            timerWillState = timerState.rest
            timerCurrentState = timerState.rest
            
            //present notification
            let completeNotification = setNotification("时间到了，已完成任务",timeToNotification: Double(fireTime),soundName: UILocalNotificationDefaultSoundName,category: "COMPLETE_CATEGORY")
            UIApplication.sharedApplication().presentLocalNotificationNow(completeNotification)
            UIApplication.sharedApplication().applicationIconBadgeNumber = 1
            
        }else if timerWillState == timerState.restComplete{
            completeHandler?(timerWillState: timerState.restComplete)
//            timerButton.setTitle(timerState.restComplete, forState: .Normal)
            timerWillState = timerState.start
            timerCurrentState = timerState.start
            
            //present notification
            let restNotification = setNotification("时间到了，休息完毕",timeToNotification: Double(fireTime),soundName: UILocalNotificationDefaultSoundName,category: "REST_COMPLETE_CATEGORY")
            UIApplication.sharedApplication().presentLocalNotificationNow(restNotification)
            UIApplication.sharedApplication().applicationIconBadgeNumber = 1
        }
        else{
            print("not have this timerState \(timerWillState)")
        }
    }
    
    func timeUp(timer:NSTimer) -> Void{
        if currentTime > 0{
            timerWillState = timerState.updating
            timerWillAction(nil)
            currentTime--
        }else if timerCurrentState == timerState.start{
            timer.invalidate()
            timerWillState = timerState.workingComplete
            timerWillAction(nil)
        }else if timerCurrentState == timerState.rest{
            timer.invalidate()
            timerWillState = timerState.restComplete
            timerWillAction(nil)
        }
    }
}