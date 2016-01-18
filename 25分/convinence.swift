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
var tmpMusicPlayer: AVAudioPlayer!
var voice = true
let voiceKey = "voice"
var lastContentOffsetX:CGFloat = 0
let transitionDelegate = TransitionDelegate()


var selectMusicToPlay: BgmFilename!
//array
var advArray = [Bgm]()
var restArray = [Bgm]()
var giveUpArray = [Bgm]()
var winArray = [Bgm]()
var restFinArray = [Bgm]()
//obj
var restMusicSet : MusicSet!
var mainMusicSet : MusicSet!
var restFinMusicSet : MusicSet!
var winMusicSet : MusicSet!

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

func initSeting(){
    
    
    //init Array
    let images = filePathesInDir("/Bgm/Images")
    let adventureFiles  = filePathesInDir("/Bgm/AdventureMusic")
    let giveUpFiles = filePathesInDir("/Bgm/GiveUpMusic")
    let restFinishFiles = filePathesInDir("/Bgm/RestFinishMusic")
    let RestMusicFiles = filePathesInDir("/Bgm/RestMusic")
    let winMusicFiles = filePathesInDir("/Bgm/WinMusic")
    
    advArray = (0..<adventureFiles.count).map{
        (i) -> Bgm in
        let dataDict = [
            Bgm.Keys.MusicPath : adventureFiles[i],
            Bgm.Keys.Image : images[i]
        ]
        let bgmIns = Bgm(dataDict: dataDict)
        return bgmIns
    }
    
    giveUpArray = (0..<giveUpFiles.count).map{
        (i) -> Bgm in
        let dataDict = [
            Bgm.Keys.MusicPath : giveUpFiles[i],
            Bgm.Keys.Image : images[i]
        ]
        let bgmIns = Bgm(dataDict: dataDict)
        return bgmIns
    }
    
    restFinArray = (0..<restFinishFiles.count).map{
        (i) -> Bgm in
        let dataDict = [
            Bgm.Keys.MusicPath : restFinishFiles[i],
            Bgm.Keys.Image : images[i]
        ]
        let bgmIns = Bgm(dataDict: dataDict)
        return bgmIns
    }
    
    restArray = (0..<RestMusicFiles.count).map{
        (i) -> Bgm in
        let dataDict = [
            Bgm.Keys.MusicPath : RestMusicFiles[i],
            Bgm.Keys.Image : images[i]
        ]
        let bgmIns = Bgm(dataDict: dataDict)
        return bgmIns
    }
    
    winArray = (0..<winMusicFiles.count).map{
        (i) -> Bgm in
        let dataDict = [
            Bgm.Keys.MusicPath : winMusicFiles[i],
            Bgm.Keys.Image : images[i]
        ]
        let bgmIns = Bgm(dataDict: dataDict)
        return bgmIns
    }
    
    
    
    let dataDict = [
        BgmFilename.Keys.AdventureFile : advArray[0].musicPath,
        BgmFilename.Keys.RestMusic : restArray[0].musicPath,
        BgmFilename.Keys.GiveUpMusic : giveUpArray[0].musicPath,
        BgmFilename.Keys.RestFinishMusic : restFinArray[0].musicPath,
        BgmFilename.Keys.WinMusic : winArray[0].musicPath,
        BgmFilename.Keys.Image : advArray[0].image
    ]
    selectMusicToPlay = BgmFilename(dataDict: dataDict)
    
    //init Obj
    restMusicSet = MusicSet(path: selectMusicToPlay.restMusic , musicKey: BgmFilename.Keys.RestMusic)
    mainMusicSet = MusicSet(path: selectMusicToPlay.adventureMusic, musicKey: BgmFilename.Keys.AdventureFile)
    restFinMusicSet = MusicSet(path: selectMusicToPlay.restFinishMusic, musicKey: BgmFilename.Keys.RestFinishMusic)
    winMusicSet = MusicSet(path: selectMusicToPlay.winMusic, musicKey: BgmFilename.Keys.WinMusic)
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

func playTmpMusic(pathURL:String){
    
    let url = NSURL(fileURLWithPath: pathURL)
    
    do{
        try tmpMusicPlayer = AVAudioPlayer(contentsOfURL: url)
    }catch{
        print("could not cteate backgroundMusic")
        print(error)
        return
    }
    
    do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
    }catch{
        print(error)
    }
    
    tmpMusicPlayer.prepareToPlay()
    tmpMusicPlayer.play()
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

class MusicSet {
    var lastContentOffset : CGFloat = 0.0
    var path:String
    var indexPath:Int = 0
    var musicKey :String
    
    init(path : String, musicKey:String){
        self.path = path
        self.musicKey = musicKey
    }
    
    func getTitle() -> String{
        let pathUrl = NSURL(fileURLWithPath: path).URLByDeletingPathExtension!
        let fileName = pathUrl.lastPathComponent!
        return fileName
    }
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

class Bgm {
    var musicPath : String
    var image : String
    
    struct Keys {
        static let MusicPath = "musicPath"
        static let Image = "image"
    }
    
    init(dataDict: [ String : AnyObject ]){
        musicPath = dataDict[Keys.MusicPath] as! String
        image = dataDict[Keys.Image] as! String
    }
    
    func getTitle() -> String{
        let pathUrl = NSURL(fileURLWithPath: musicPath).URLByDeletingPathExtension!
        let fileName = pathUrl.lastPathComponent!
        return fileName
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

func makeBorderBtn(btn:UIButton,borderColor:CGColor,radious:CGFloat){
    btn.layer.borderColor = borderColor
    btn.layer.borderWidth = 1.0
    btn.layer.cornerRadius = radious
}

func makeRadiusBtn(btn:UIButton,borderColor:CGColor){
    let btnH:CGFloat = CGRectGetHeight(btn.bounds)
    makeBorderBtn(btn, borderColor: borderColor, radious: btnH / 2)
}




