//
//  CollectionViewController.swift
//  CircularCollectionView
//
//  Created by Rounak Jain on 10/05/15.
//  Copyright (c) 2015 Rounak Jain. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController{
  
    let lbSongTitle = UILabel()
    //MARK: -scrollViewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        print(CircularCollectionViewLayout.lastCenterIndex)
        lbSongTitle.text = String(CircularCollectionViewLayout.lastCenterIndex)
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        lastContentOffsetX = collectionView!.contentOffset.x
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Register cell classes
    collectionView!.registerNib(UINib(nibName: "CircularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    let imageView = UIImageView(image: UIImage(named: "bg-dark.jpg"))
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    collectionView!.backgroundView = imageView
    
    self.collectionView?.showsHorizontalScrollIndicator = false
    self.collectionView?.delegate = self
    
    initView()
    lbSongTitle.text = "0"
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
        selectMusicToPlay = bgmArray[indexPath.row]
        
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
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func noFunc(){
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
}
