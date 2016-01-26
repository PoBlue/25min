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
struct musicSetKeys {
    static let adv = "advMusicKey"
    static let rest = "restMusicKey"
    static let restFin = "restFinMusicKey"
    static let win = "winMusicKey"
}


var selectMusicToPlay: BgmFilename!
//array
var advArray = [Bgm]()
var restArray = [Bgm]()
var winArray = [Bgm]()
var restFinArray = [Bgm]()
//obj
var restMusicSet : MusicSet!
var mainMusicSet : MusicSet!
var restFinMusicSet : MusicSet!
var winMusicSet : MusicSet!
let appMainBundlePath = NSBundle.mainBundle().bundlePath

func filePathesInDir(dirPath:String,ext:String?) -> [String]{
    var filePathes = [String]()
    
    let fileManager = NSFileManager.defaultManager()
    
    
    let enumerator = fileManager.enumeratorAtPath(appMainBundlePath + dirPath)
    var fileURL:String
    
    while let element = enumerator?.nextObject() as? String{
        if let ext = ext {
            if element.hasSuffix(ext){
                fileURL = appMainBundlePath + dirPath + "/" + element
                filePathes.append(fileURL)
            }
        }else{
                fileURL = appMainBundlePath + dirPath + "/" + element
                filePathes.append(fileURL)
        }
    }
    
    return filePathes
}

let longMusicDirPath = "/Bgm/LongMusic"
let longMusicImagesDirPath = longMusicDirPath + "/Images"
let shortMusicDirPath = "/Bgm/ShortMusic"
let shortMusicImagesDirPath = shortMusicDirPath + "/Images"

func initSeting(){
    
    
    //init Array
    let advImages = filePathesInDir(longMusicImagesDirPath,ext: nil)
    let restFinImages = filePathesInDir(shortMusicImagesDirPath,ext: nil)
    let restImages = filePathesInDir(longMusicImagesDirPath,ext: nil)
    let winImages = filePathesInDir(shortMusicImagesDirPath,ext: nil)
    
    let adventureFiles  = filePathesInDir(longMusicDirPath,ext: "mp3")
    let restFinishFiles = filePathesInDir(shortMusicDirPath,ext: "mp3")
    let RestMusicFiles = filePathesInDir(longMusicDirPath,ext: "mp3")
    let winMusicFiles = filePathesInDir(shortMusicDirPath,ext: "mp3")
    
    advArray = bgmArrayWithFile(adventureFiles, musicImages: advImages)
    
    
    restFinArray = bgmArrayWithFile(restFinishFiles, musicImages: restFinImages)
    
    restArray = bgmArrayWithFile(RestMusicFiles, musicImages: restImages)
    
    winArray = bgmArrayWithFile(winMusicFiles, musicImages: winImages)
    
    let dataDict = [
        BgmFilename.Keys.AdventureFile : advArray[0].musicPath,
        BgmFilename.Keys.RestMusic : restArray[0].musicPath,
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
    
    restoreMusicSet()
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

class MusicSet : NSObject, NSCoding{
    var lastContentOffset : CGFloat = 0.0
    var path:String = ""
    var indexPath:Int = 0
    var musicKey :String = ""
    
    struct Keys {
        static let LastCOffset = "lastContentOffset"
        static let Path = "path"
        static let IndexPath = "indexPath"
        static let musicKey = "musicKey"
    }
    
    init(path : String, musicKey:String){
        self.path = path
        self.musicKey = musicKey
    }
    
    func copySelf(copyFrom:MusicSet?) -> MusicSet {
        if let copy = copyFrom{
            self.path = copy.path
            self.lastContentOffset = copy.lastContentOffset
            self.musicKey = copy.musicKey
            self.indexPath = copy.indexPath
            return self
        }
        let copyIns = MusicSet(path: self.path, musicKey: self.musicKey)
        copyIns.lastContentOffset = self.lastContentOffset
        copyIns.indexPath = self.indexPath
        return copyIns
    }
    
    func getTitle() -> String{
        let pathUrl = NSURL(fileURLWithPath: path).URLByDeletingPathExtension!
        let fileName = pathUrl.lastPathComponent!
        return fileName
    }
    

    // MARK: - NSCoding
    
    func encodeWithCoder(archiver: NSCoder) {
        
        // archive the information inside the Person, one property at a time
        archiver.encodeObject(lastContentOffset, forKey: Keys.LastCOffset)
        archiver.encodeObject(self.path, forKey: Keys.Path)
        archiver.encodeObject(indexPath, forKey: Keys.IndexPath)
        archiver.encodeObject(musicKey, forKey: Keys.musicKey)
    }

    required init(coder unarchiver: NSCoder) {
        super.init()
        // Unarchive the data, one property at a time
        lastContentOffset = unarchiver.decodeObjectForKey(Keys.LastCOffset) as! CGFloat
        indexPath = unarchiver.decodeObjectForKey(Keys.IndexPath) as! Int
        musicKey = unarchiver.decodeObjectForKey(Keys.musicKey) as! String
        path = unarchiver.decodeObjectForKey(Keys.Path) as! String
    }
}

class BgmFilename {
    var adventureMusic:String
    var winMusic:String
    var restMusic:String
    var restFinishMusic:String
    var image:String
    
    struct Keys {
        static let AdventureFile = "adventureFile"
        static let WinMusic = "winMusic"
        static let RestMusic = "restMusic"
        static let RestFinishMusic = "restFinishMusic"
        static let Image = "image"
    }
    
    init(dataDict: [ String : AnyObject ]){
        adventureMusic = dataDict[Keys.AdventureFile] as! String
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

func getPathTitle(path:String) -> String{
    let pathUrl = NSURL(fileURLWithPath: path).URLByDeletingPathExtension!
    let fileName = pathUrl.lastPathComponent!
    return fileName
}

let defaultImagePath = appMainBundlePath + "/Bgm/default.png"
func bgmArrayWithFile(musicFiles:[String],musicImages:[String]) -> [Bgm] {
    let tmpArray = (0..<musicFiles.count).map{
        (i) -> Bgm in
        var dataDict = [
            Bgm.Keys.MusicPath : musicFiles[i],
        ]
        
        dataDict[Bgm.Keys.Image] = defaultImagePath
        for(var ind = 0 ; ind < musicImages.count; ind += 1){
            if getPathTitle(dataDict[Bgm.Keys.MusicPath]!) == getPathTitle(musicImages[ind]){
                dataDict[Bgm.Keys.Image] = musicImages[ind]
            }
        }
        
        let bgmIns = Bgm(dataDict: dataDict)
        return bgmIns
    }
    return tmpArray
}

var musicSetFilePath : String {
    let manager = NSFileManager.defaultManager()
    let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    return url.URLByAppendingPathComponent("musicSet").path!
}


func restoreMusicSet(){
    if let ins = NSKeyedUnarchiver.unarchiveObjectWithFile(musicSetFilePath) as? [MusicSet]{
        mainMusicSet = ins[0]
        restMusicSet = ins[1]
        winMusicSet = ins[2]
        restFinMusicSet = ins[3]
        
        selectMusicToPlay.adventureMusic = mainMusicSet.path
        selectMusicToPlay.restMusic = restMusicSet.path
        selectMusicToPlay.winMusic = winMusicSet.path
        selectMusicToPlay.restFinishMusic = restFinMusicSet.path
    }
}

import MediaPlayer
let whiteImage = UIImage(named:"whiteImage")!
let textPoint = CGPoint(x: whiteImage.size.width  / 3, y: whiteImage.size.height / 3 )
let textSize : CGFloat = 60

func configNowPlaying(currentTime:NSTimeInterval,fireTime:NSTimeInterval){
    
    let timeImage = textToImage(formatToDisplayTime(Int(fireTime - currentTime)),inImage: whiteImage,atPoint: textPoint)
    
    let mpPlayer = MPNowPlayingInfoCenter.defaultCenter()
    
    let tmpPlayingInfo = [ MPMediaItemPropertyTitle : "25min",
        MPMediaItemPropertyArtwork : MPMediaItemArtwork(image:timeImage) ,
        MPNowPlayingInfoPropertyElapsedPlaybackTime : NSNumber(double: currentTime),
        MPNowPlayingInfoPropertyPlaybackRate : 1.0,
        MPMediaItemPropertyPlaybackDuration: fireTime
    ]
    
    mpPlayer.nowPlayingInfo = tmpPlayingInfo
    
    //remote button enable
   MPRemoteCommandCenter.sharedCommandCenter().previousTrackCommand.enabled = false
    MPRemoteCommandCenter.sharedCommandCenter().skipBackwardCommand .enabled = false
    MPRemoteCommandCenter.sharedCommandCenter().seekBackwardCommand.enabled = false
}

func textToImage(drawText: NSString, inImage: UIImage, atPoint:CGPoint)->UIImage{
    
    // Setup the font specific variables
//    let textColor: UIColor = UIColor.blackColor()
    let textFont: UIFont = UIFont(name: "Helvetica Bold", size: textSize)!
    
    //Setup the image context using the passed image.
    UIGraphicsBeginImageContext(inImage.size)
    
    //Setups up the font attributes that will be later used to dictate how the text should be drawn
//    let textFontAttributes = [
//        NSFontAttributeName: textFont,
//        NSForegroundColorAttributeName: textColor,
//    ]
    
    //Put the image into a rectangle as large as the original image.
    inImage.drawInRect(CGRectMake(0, 0, inImage.size.width, inImage.size.height))
    
    // Creating a point within the space that is as bit as the image.
//    let rect: CGRect = CGRectMake(atPoint.x, atPoint.y, inImage.size.width, inImage.size.height)
    
    //Now Draw the text into an image.
//    drawText.drawInRect(rect, withAttributes: textFontAttributes)
    drawSting(drawText, withFont: textFont, inRect: CGRectMake(0, 0, inImage.size.width, inImage.size.height))
    
    // Create a new image out of the images we have created
    let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    
    // End the context now that we have the image we need
    UIGraphicsEndImageContext()
    
    //And pass it back up to the caller.
    return newImage
    
}

func drawSting(s:NSString,withFont font:UIFont,inRect contextRect: CGRect){
    let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
//    paragraphStyle.lineBreakMode = NSLineBreakMode.ByTruncatingTail
    paragraphStyle.alignment = NSTextAlignment.Center
    
    let attr = [
        NSFontAttributeName : font,
        NSForegroundColorAttributeName : UIColor.blackColor(),
        NSParagraphStyleAttributeName : paragraphStyle
    ]
    
    let size = s.sizeWithAttributes(attr)
    
    let xOffset = contextRect.origin.x + floor((contextRect.size.width - size.width) / 2)
    let yOffset = contextRect.origin.y + floor((contextRect.size.height - size.height) / 2)
    let textRect = CGRectMake(xOffset, yOffset, size.width, size.height)
    
    s.drawInRect(textRect, withAttributes: attr)
}
