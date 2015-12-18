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
  
  let images: [String] = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: "Images") 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Register cell classes
    collectionView!.registerNib(UINib(nibName: "CircularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    let imageView = UIImageView(image: UIImage(named: "bg-dark.jpg"))
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    collectionView!.backgroundView = imageView
  }
  
}

extension CollectionViewController {
  
  // MARK: UICollectionViewDataSource
  
  override func collectionView(collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
      return images.count
  }
  
  override func collectionView(collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CircularCollectionViewCell
      cell.imageName = images[indexPath.row]
      return cell
  }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.modalPresentationStyle = .Custom
        let delegate = TransitionDelegate()
        self.transitioningDelegate = delegate
        lastContentOffsetX = collectionView.contentOffset.x
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
  
}
