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
    
    let lbSongTitle = UILabel()
    //MARK: -scrollViewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        print(musicSet.indexPath)
        musicSet.path = bgmArray[musicSet.indexPath].musicPath
        lbSongTitle.text = String(musicSet.getTitle())
        
    }
    
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        musicSet.lastContentOffset = collectionView!.contentOffset.x
        lastContentOffsetX = musicSet.lastContentOffset
        playTmpMusic(musicSet.path)
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //init set 
    tmpMusicSet = musicSet.copy(nil)
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
        let lbSongTitleW = viewW / 2
        let lbSongTitleY = viewH / 4
        
        let btnW = viewW / 7
        let btnH = btnW
        let btnY = viewH - btnH - 20
        
        lbSongTitle.center = CGPoint(x: viewW / 2, y: lbSongTitleY)
        lbSongTitle.bounds = CGRect(x: 0, y: 0, width: lbSongTitleW, height: lbSongTitleH)
        
        btnA.center = CGPoint(x: (viewW / 2) - btnW, y: btnY)
        btnB.center = CGPoint(x: (viewW / 2) + btnW, y: btnY)
        btnA.bounds = CGRect(x: 0, y: 0, width: btnW, height: btnH)
        btnB.bounds = CGRect(x: 0, y: 0, width: btnW, height: btnH)
        
        lbSongTitle.font = lbSongTitle.font.fontWithSize(lbSongTitleH / 2)
        lbSongTitle.textColor = UIColor.whiteColor()
        lbSongTitle.textAlignment = .Center
        lbSongTitle.adjustsFontSizeToFitWidth = true
        
        btnA.setTitle("确定", forState: .Normal)
        btnB.setTitle("取消", forState: .Normal)
        
        btnA.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        btnB.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        btnA.addTarget(self, action: "tapBtn:", forControlEvents: .TouchUpInside)
        btnB.addTarget(self, action: "tapBtn:", forControlEvents: .TouchUpInside)
        
        makeBorderBtn(btnA, borderColor: UIColor.yellowColor().CGColor, radious: 3)
        makeBorderBtn(btnB, borderColor: UIColor.whiteColor().CGColor, radious: 3)
        
        self.view.addSubview(lbSongTitle)
        self.view.addSubview(btnA)
        self.view.addSubview(btnB)
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
        musicSet.copy(tmpMusicSet)
        dismissViewController()
    }
    
    func dismissViewController(){
        tmpMusicPlayer.pause()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
