//
//  Timer.swift
//  25分
//
//  Created by blues on 15/12/12.
//  Copyright © 2015年 blues. All rights reserved.
//

import Foundation
import UIKit

protocol timerDelegate{
    func updateingTime(currentTime:Int)
    func timerStateToController(timerWillState:String)
}

class Timer : NSObject{
    
    var timerCurrentState = timerState.start
    let fireTime = 9
    let restFireTime = 6
    var currentTime = 60 * 25
    var time:NSTimer!
    var timerWillState = timerState.start
    
    var delegate:timerDelegate?
    
    static let shareInstance = Timer()
    
    func timerWillAction() {
        switch timerWillState{
        case timerState.start :
            currentTime = fireTime
            //set timer
            self.time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeUp:", userInfo: nil, repeats: true)
            
            
            delegate?.timerStateToController(timerState.giveUp)
            timerWillState = timerState.giveUp
        case timerState.giveUp:
            
            time.invalidate()
            delegate?.timerStateToController(timerState.start)
            timerWillState = timerState.start
            
        case timerState.rest:
            //set timer
            currentTime = restFireTime
            self.time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeUp:", userInfo: nil, repeats: true)
            
            delegate?.timerStateToController(timerState.giveUp)
            timerWillState = timerState.giveUp
        case timerState.workingComplete:
            delegate?.timerStateToController(timerState.workingComplete)
            timerWillState = timerState.rest
            timerCurrentState = timerState.rest
            
            //present notification
            let completeNotification = setNotification("时间到了，已完成任务",timeToNotification: Double(fireTime),soundName: UILocalNotificationDefaultSoundName,category: "COMPLETE_CATEGORY")
            UIApplication.sharedApplication().presentLocalNotificationNow(completeNotification)
            UIApplication.sharedApplication().applicationIconBadgeNumber = 1
            
        case timerState.restComplete:
            delegate?.timerStateToController(timerState.restComplete)
            
            timerWillState = timerState.start
            timerCurrentState = timerState.start
            
            //present notification
            let restNotification = setNotification("时间到了，休息完毕",timeToNotification: Double(fireTime),soundName: UILocalNotificationDefaultSoundName,category: "REST_COMPLETE_CATEGORY")
            UIApplication.sharedApplication().presentLocalNotificationNow(restNotification)
            UIApplication.sharedApplication().applicationIconBadgeNumber = 1
        
        default:
            print("not have this timerState \(timerWillState)")
        }
    }
    
    func timeUp(timer:NSTimer) -> Void{
        delegate?.updateingTime(currentTime)
        
        if currentTime > 0{
            currentTime--
        }else if timerCurrentState == timerState.start{
            timer.invalidate()
            timerWillState = timerState.workingComplete
            timerWillAction()
        }else if timerCurrentState == timerState.rest{
            timer.invalidate()
            timerWillState = timerState.restComplete
            timerWillAction()
        }
        
    }
}