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
    
    var timerCurrentState = timerState.giveUp
    var fireTime = 25 * 60
    var restFireTime = 5 * 60
    var duractionTime = 25 * 60
    var fireDate:NSDate!
    var currentTime = 60 * 25
    var time:NSTimer!
    var timerWillState = timerState.start
    
    
    var delegate:timerDelegate?
    
    static var shareInstance = Timer()
    
    override init(){
        //set timer
        super.init()
        self.time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeUp:", userInfo: nil, repeats: true)
    }
    
    func timerAction(){
        switch timerCurrentState{
        case timerState.giveUp:
            print("give up")
        case timerState.start:
            //set timer
            
            delegate?.timerStateToController(timerState.giveUp)
            timerWillState = timerState.giveUp
            print("starting")
        case timerState.rest:
            
            delegate?.timerStateToController(timerState.giveUp)
            timerWillState = timerState.giveUp
            print("resting")
        default:
            print("error:\(timerCurrentState)")
        }
    }
    
    func timerWillAction() {
        switch timerWillState{
        case timerState.start :
            playBackgroundMusic(selectMusicToPlay.adventureMusic,cycle: true)
            timerCurrentState = timerState.start
            currentTime = fireTime
            
            //set fire Date
            fireDate = NSDate(timeIntervalSinceNow: Double(fireTime))
            
            
            delegate?.timerStateToController(timerState.giveUp)
            timerWillState = timerState.giveUp
        case timerState.giveUp:
            self.currentTime = fireTime
            self.timerCurrentState = timerState.giveUp
            if backgroundMusicPlayer != nil{
                backgroundMusicPlayer.pause()
            }
            delegate?.timerStateToController(timerState.start)
            timerWillState = timerState.start
            
        case timerState.rest:
            playBackgroundMusic(selectMusicToPlay.restMusic, cycle: true)
            timerCurrentState = timerState.rest
            //set fireDate
            fireDate = NSDate(timeIntervalSinceNow: Double(restFireTime))
            //set timer
            currentTime = restFireTime
            
            delegate?.timerStateToController(timerState.giveUp)
            timerWillState = timerState.giveUp
        case timerState.workingComplete:
            playTmpMusic(selectMusicToPlay.winMusic)
            delegate?.timerStateToController(timerState.workingComplete)
            timerWillState = timerState.rest
            duractionTime = restFireTime
            
            
        case timerState.restComplete:
            playTmpMusic(selectMusicToPlay.restFinishMusic)
            delegate?.timerStateToController(timerState.restComplete)
            
            timerWillState = timerState.start
            duractionTime = fireTime
            
                    
        default:
            print("not have this timerState \(timerWillState)")
        }
    }
    
    func timeUp(timer:NSTimer) -> Void{
        
        if timerCurrentState == timerState.giveUp{
            return
        }
        
        delegate?.updateingTime(currentTime)
        
        if currentTime > 0{
            currentTime--
            configNowPlaying(Double(duractionTime - currentTime), fireTime: Double(self.duractionTime))
        }else if timerCurrentState == timerState.start{
            timerCurrentState = timerState.giveUp
            timerWillState = timerState.workingComplete
            timerWillAction()
        }else if timerCurrentState == timerState.rest{
            timerCurrentState = timerState.giveUp
            timerWillState = timerState.restComplete
            timerWillAction()
        }
        
    }
}