//
//  CollectionViewController.swift
//  CircularCollectionView
//
//  Created by Rounak Jain on 10/05/15.
//  Copyright (c) 2015 Rounak Jain. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"
var tmpMusicSet: MusicSet!

class CollectionViewController: UICollectionViewController{
  
    var bgmArray = [Bgm]()
    var musicSet : MusicSet!
    var playing = false
    let btnVoice = UIButton()
    
    let lbSongTitle = UILabel()
    //MARK: -scrollViewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        musicSet.path = bgmArray[musicSet.indexPath].musicPath
        lbSongTitle.text = String(musicSet.getTitle())
        
    }
    
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        musicSet.lastContentOffset = collectionView!.contentOffset.x
        lastContentOffsetX = musicSet.lastContentOffset
        if playing{
            playTmpMusic(musicSet.path)
        }
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //init set 
    tmpMusicSet = musicSet.copySelf(nil)
    // Register cell classes
    collectionView!.registerNib(UINib(nibName: "CircularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    let imageView = UIImageView(image: UIImage(named: "bg-dark.jpg"))
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    collectionView!.backgroundView = imageView
    
    self.collectionView?.showsHorizontalScrollIndicator = false
    self.collectionView?.delegate = self
    
    initView()
    lbSongTitle.text = musicSet.getTitle()
    
  }
  
}

extension CollectionViewController {
  
  // MARK: UICollectionViewDataSource
  
  override func collectionView(collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
      return bgmArray.count
  }
  
  override func collectionView(collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CircularCollectionViewCell
      cell.imageName = bgmArray[indexPath.row].image
      return cell
  }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //select Music to Play
        yesFunc()
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    
    func tapBtn(sender: AnyObject){
        let btn = sender as! UIButton
        let btnText = btn.titleLabel!.text!
        switch btnText{
            case "确定":
                yesFunc()
            case "取消":
                noFunc()
            case "Play":
                playMusicFunc(true)
            case "停止":
                playMusicFunc(false)
        default:
            print("其它")
        }
    }
  
}

extension CollectionViewController{
    func initView(){
        
        let viewH = CGRectGetHeight(self.view.bounds)
        let viewW = CGRectGetWidth(self.view.bounds)
        
        let btnA = UIButton()
        let btnB = UIButton()
        
        let lbSongTitleH = viewW / 6
        let lbSongTitleW = viewW
        let lbSongTitleY = viewH / 4
        
        let btnW = viewW / 7
        let btnH = btnW
        let btnY = viewH - btnH - 20
        let voiceBtnW = btnW * 3
        let voiceBtnH = btnW * 1.5
        let voiceBtnY = btnY - 10
        
        lbSongTitle.center = CGPoint(x: viewW / 2, y: lbSongTitleY)
        lbSongTitle.bounds = CGRect(x: 0, y: 0, width: lbSongTitleW, height: lbSongTitleH)
        
        btnVoice.frame = CGRect(x: viewW - voiceBtnW  , y: 0, width: voiceBtnW, height: voiceBtnH)
        
        btnVoice.center = CGPoint(x: viewW / 2, y: voiceBtnY)
        btnA.center = CGPoint(x: (viewW / 2) - btnW - (voiceBtnW / 2), y: voiceBtnY)
        btnB.center = CGPoint(x: (viewW / 2) + btnW + (voiceBtnW / 2), y: voiceBtnY)
        
        btnVoice.bounds = CGRect(x: 0, y: 0, width: voiceBtnW, height: voiceBtnH)
        btnA.bounds = CGRect(x: 0, y: 0, width: btnW, height: btnH)
        btnB.bounds = CGRect(x: 0, y: 0, width: btnW, height: btnH)
        
        lbSongTitle.font = lbSongTitle.font.fontWithSize(lbSongTitleH / 4)
        lbSongTitle.textColor = UIColor.whiteColor()
        lbSongTitle.textAlignment = .Center
        lbSongTitle.adjustsFontSizeToFitWidth = false
        
        btnA.setTitle("确定", forState: .Normal)
        btnB.setTitle("取消", forState: .Normal)
        btnVoice.setTitle("Play", forState: .Normal)
        btnVoice.titleLabel?.font = btnVoice.titleLabel!.font.fontWithSize(voiceBtnH / 2.8)
        
        btnA.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btnB.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btnVoice.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        btnA.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        btnB.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        btnVoice.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        
        
        btnA.addTarget(self, action: "tapBtn:", forControlEvents: .TouchUpInside)
        btnB.addTarget(self, action: "tapBtn:", forControlEvents: .TouchUpInside)
        btnVoice.addTarget(self, action: "tapBtn:", forControlEvents: .TouchUpInside)
        
//        makeBorderBtn(btnA, borderColor: UIColor.blackColor().CGColor, radious: 3)
//        makeBorderBtn(btnB, borderColor: UIColor.blackColor().CGColor, radious: 3)
        makeRadiusBtn(btnVoice, borderColor: UIColor.yellowColor().CGColor)
        
        self.view.addSubview(lbSongTitle)
        self.view.addSubview(btnA)
        self.view.addSubview(btnB)
        self.view.addSubview(btnVoice)
    }
    
    func yesFunc(){
        switch musicSet.musicKey{
        case BgmFilename.Keys.AdventureFile:
            selectMusicToPlay.adventureMusic = musicSet.path
        case BgmFilename.Keys.RestFinishMusic:
            selectMusicToPlay.restFinishMusic = musicSet.path
        case BgmFilename.Keys.RestMusic:
            selectMusicToPlay.restMusic = musicSet.path
        case BgmFilename.Keys.WinMusic:
            selectMusicToPlay.winMusic = musicSet.path
        default:
            print("error in YesFunc")
        }
        dismissViewController()
    }
    
    func noFunc(){
        musicSet.copySelf(tmpMusicSet)
        dismissViewController()
    }
    
    func playMusicFunc(mode:Bool){
        if mode {
            btnVoice.setTitle("停止", forState: .Normal)
            makeRadiusBtn(btnVoice, borderColor: UIColor.redColor().CGColor)
            playing = true
            playTmpMusic(musicSet.path)
        }else{
            btnVoice.setTitle("Play", forState: .Normal)
            makeRadiusBtn(btnVoice, borderColor: UIColor.yellowColor().CGColor)
            playing = false
            tmpMusicPlayer.pause()
        }
        print("mode \(mode)")
    }
    
    func dismissViewController(){
        if tmpMusicPlayer != nil{
            tmpMusicPlayer.pause()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
