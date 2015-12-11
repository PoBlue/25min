//
//  ViewController.swift
//  25分
//
//  Created by blues on 15/12/11.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    var timerWillState = timerState.start
    var timerCurrentState = timerState.start
    let fireTime = 9
    let restFireTime = 6
    var currentTime = 60 * 25
    var time:NSTimer!
    
    func setNotification(body:String,timeToNotification:Double,soundName:String,category:String) -> UILocalNotification {
        let localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "滑动查看信息"
        localNotification.applicationIconBadgeNumber = 0
        localNotification.alertBody = body
        localNotification.soundName = soundName
        localNotification.fireDate = NSDate(timeIntervalSinceNow: timeToNotification)
        localNotification.category = category
        return localNotification
    }
    
    func timerWillAction() {
        if  timerWillState == timerState.start {
            currentTime = fireTime
            //set timer
            self.time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeUp:", userInfo: nil, repeats: true)
            
            //set notification
            let completeNotification = setNotification("时间到了，已完成任务",timeToNotification: Double(fireTime),soundName: UILocalNotificationDefaultSoundName,category: "COMPLETE_CATEGORY")
            
            UIApplication.sharedApplication().scheduleLocalNotification(completeNotification)
            
            timerButton.setTitle(timerState.giveUp, forState: .Normal)
            timerWillState = timerState.giveUp
        }else if timerWillState == timerState.giveUp{
            
            time.invalidate()
            timerLabel.text = formatToDisplayTime(fireTime)
            timerButton.setTitle(timerState.start, forState: .Normal)
            timerWillState = timerState.start
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()
        }else if timerWillState == timerState.rest{
            //set timer
            currentTime = restFireTime
            self.time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeUp:", userInfo: nil, repeats: true)
            
            //set notification
            let restNotification = setNotification("时间到了，休息完毕",timeToNotification: Double(fireTime),soundName: UILocalNotificationDefaultSoundName,category: "REST_COMPLETE_CATEGORY")
            
            UIApplication.sharedApplication().scheduleLocalNotification(restNotification)
            
            timerButton.setTitle(timerState.giveUp, forState: .Normal)
            timerWillState = timerState.giveUp
        }else if timerWillState == timerState.workingComplete{
            timerButton.setTitle(timerState.workingComplete, forState: .Normal)
            timerWillState = timerState.rest
            timerCurrentState = timerState.rest
        }else if timerWillState == timerState.restComplete{
            timerButton.setTitle(timerState.restComplete, forState: .Normal)
            timerWillState = timerState.start
            timerCurrentState = timerState.start
        }
        else{
            print("not have this timerState \(timerWillState)")
        }
    }
    
    
    @IBAction func touchUpTimerButton(sender: AnyObject) {
        timerWillAction()
    }
    
    func timeUp(timer:NSTimer) -> Void{
        if currentTime > 0{
            timerLabel.text = formatToDisplayTime(currentTime)
            currentTime--
            return
        }else if timerCurrentState == timerState.start{
            timer.invalidate()
            timerLabel.text = formatToDisplayTime(currentTime)
            timerWillState = timerState.workingComplete
            timerWillAction()
        }else if timerCurrentState == timerState.rest{
            timer.invalidate()
            timerLabel.text = formatToDisplayTime(currentTime)
            timerWillState = timerState.restComplete
            timerWillAction()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timerLabel.text = formatToDisplayTime(fireTime)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -easy method
    
    func formatToDisplayTime(currentTime:Int) -> String{
        let min = currentTime / 60
        let second = currentTime % 60
        let time = String(format: "%02d:%02d", arguments: [min,second])
        return time
    }


}

