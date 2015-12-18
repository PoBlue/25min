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


var selectMusicToPlay: BgmFilename!
var bgmArray = [BgmFilename]()

func filePathesInDir(dirPath:String) -> [String]{
    var filePathes = [String]()
    
    let appMainBundlePath = NSBundle.mainBundle().bundlePath
    let fileManager = NSFileManager.defaultManager()
    let enumerator = fileManager.enumeratorAtPath(appMainBundlePath + dirPath)
    var fileURL:String
    
    while let element = enumerator?.nextObject() as? String{
        fileURL = appMainBundlePath + dirPath + "/" + element
        filePathes.append(fileURL)
    }
    
    return filePathes
}

func setMusicToPlay(){
    
    let images = filePathesInDir("/Bgm/Images")
    let adventureFiles  = filePathesInDir("/Bgm/AdventureMusic")
    let giveUpFiles = filePathesInDir("/Bgm/GiveUpMusic")
    let restFinishFiles = filePathesInDir("/Bgm/RestFinishMusic")
    let RestMusicFiles = filePathesInDir("/Bgm/RestMusic")
    let winMusicFiles = filePathesInDir("/Bgm/WinMusic")
    
    let randomCount = Int(arc4random())
    
    bgmArray = (0..<adventureFiles.count).map{
        (i) -> BgmFilename in
        let dataDict = [
            BgmFilename.Keys.AdventureFile : adventureFiles[i],
            BgmFilename.Keys.RestMusic : RestMusicFiles[i],
            BgmFilename.Keys.GiveUpMusic : giveUpFiles[0],
            BgmFilename.Keys.RestFinishMusic : restFinishFiles[randomCount % restFinishFiles.count],
            BgmFilename.Keys.WinMusic : winMusicFiles[randomCount % winMusicFiles.count],
            BgmFilename.Keys.Image : images[i]
        ]
        let bgmIns = BgmFilename(dataDict: dataDict)
        return bgmIns
    }
    selectMusicToPlay = bgmArray[0]
}


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

func playBackgroundMusic(pathURL:String,cycle:Bool){
    
    let url = NSURL(fileURLWithPath: pathURL)
    
//    if url == nil{
//        print("could not find file \(filename)")
//        return
//    }
    
    do{
        try backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: url)
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

class BgmFilename {
    var adventureMusic:String
    var giveUpMusic:String
    var winMusic:String
    var restMusic:String
    var restFinishMusic:String
    var image:String
    
    struct Keys {
        static let AdventureFile = "adventureFile"
        static let GiveUpMusic = "giveUpMusic"
        static let WinMusic = "winMusic"
        static let RestMusic = "restMusic"
        static let RestFinishMusic = "restFinishMusic"
        static let Image = "image"
    }
    
    init(dataDict: [ String : AnyObject ]){
        adventureMusic = dataDict[Keys.AdventureFile] as! String
        giveUpMusic = dataDict[Keys.GiveUpMusic] as! String
        winMusic = dataDict[Keys.WinMusic] as! String
        restMusic = dataDict[Keys.RestMusic] as! String
        restFinishMusic = dataDict[Keys.RestFinishMusic] as! String
        image = dataDict[Keys.Image] as! String
    }
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




