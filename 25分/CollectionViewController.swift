//
//  CollectionViewController.swift
//  CircularCollectionView
//
//  Created by Rounak Jain on 10/05/15.
//  Copyright (c) 2015 Rounak Jain. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Register cell classes
    collectionView!.registerNib(UINib(nibName: "CircularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    let imageView = UIImageView(image: UIImage(named: "bg-dark.jpg"))
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    collectionView!.backgroundView = imageView
    
    initView()
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
        lastContentOffsetX = collectionView.contentOffset.x
        self.dismissViewControllerAnimated(true, completion: nil)
        
        selectMusicToPlay = bgmArray[indexPath.row]
    
    }
    
    
    
  
}

extension CollectionViewController{
    func initView(){
        let btnA = UIButton()
        let btnB = UIButton()
        
        let viewH = CGRectGetHeight(self.view.bounds)
        let viewW = CGRectGetWidth(self.view.bounds)
        let btnW = viewW / 6
        let btnH = btnW
        let btnY = viewH * 3 / 4
        
        
        btnA.center = CGPoint(x: (viewW / 2) - btnW, y: btnY)
        btnB.center = CGPoint(x: (viewW / 2) + btnW, y: btnY)
        btnA.bounds = CGRect(x: 0, y: 0, width: btnW, height: btnH)
        btnB.bounds = CGRect(x: 0, y: 0, width: btnW, height: btnH)
        
        btnA.setTitle("A", forState: .Normal)
        btnB.setTitle("B", forState: .Normal)
        
        self.view.addSubview(btnA)
        self.view.addSubview(btnB)
    }
}
