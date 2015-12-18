//
//  content.swift
//  25分
//
//  Created by blues on 15/12/11.
//  Copyright © 2015年 blues. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer!
var voice = true
let voiceKey = "voice"
var lastContentOffsetX:CGFloat = 0
let transitionDelegate = TransitionDelegate()


func voiceModeSwich(voiceMode:Bool){
    if voiceMode{
        if backgroundMusicPlayer != nil {
           backgroundMusicPlayer.volume = 1
        }
       return
    }
    
    if (backgroundMusicPlayer != nil) {
        backgroundMusicPlayer.volume = 0
    }
}

func playBackgroundMusic(filename:String,cycle:Bool){
    
    let url = NSBundle.mainBundle().URLForResource(filename, withExtension: "mp3")
    
    if url == nil{
        print("could not find file \(filename)")
        return
    }
    
    do{
        try backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: url!)
    }catch{
        print("could not cteate backgroundMusic")
        print(error)
        return
    }
    
    if cycle{
        backgroundMusicPlayer.numberOfLoops = -1
    }
    
    do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
    }catch{
        print(error)
    }
    
    backgroundMusicPlayer.prepareToPlay()
    voiceModeSwich(voice)
    backgroundMusicPlayer.play()
}

struct bgmFilename {
    static var musicFile = "09 - Underground"
    static var giveUpMusic = "68 - Lose"
    static var winMusic = "07 - Course Clear"
    static var restMusic = "02 - Menu"
    static var restFinishMusic = "84 - All Star Coins Collected"
}

struct timerState {
    static let start = "开始"
    static let giveUp = "放弃"
    static let workingComplete = "完成工作"
    static let restComplete = "休息完了"
    static let rest = "休息"
    static let updating = "时间更新中"
}

func setNotification(body:String,timeToNotification:Double,soundName:String,category:String) -> UILocalNotification {
    let localNotification:UILocalNotification = UILocalNotification()
    localNotification.alertAction = "滑动查看信息"
    localNotification.applicationIconBadgeNumber = 0
    localNotification.alertBody = body
    localNotification.soundName = soundName
    localNotification.fireDate = NSDate(timeIntervalSinceNow: timeToNotification)
    localNotification.category = category
    localNotification.applicationIconBadgeNumber = 1
    return localNotification
}

func formatToDisplayTime(currentTime:Int) -> String{
    let min = currentTime / 60
    let second = currentTime % 60
    let time = String(format: "%02d:%02d", arguments: [min,second])
    return time
}




