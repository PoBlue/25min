//
//  CircularCollectionViewLayout.swift
//  CircularCollectionView
//
//  Created by blues on 15/12/16.
//  Copyright © 2015年 Rounak Jain. All rights reserved.
//

import UIKit

class CircularCollectionViewLayoutAttributes:UICollectionViewLayoutAttributes {

  var anchorPoint = CGPoint(x: 0.5, y: 0.5)
  
  var angle:CGFloat = 0 {
    didSet{
      zIndex = Int(angle*1000000)
      transform = CGAffineTransformMakeRotation(angle)
    }
  }
  
  override func copyWithZone(zone: NSZone) -> AnyObject {
    let copiedAttributes: CircularCollectionViewLayoutAttributes =
    super.copyWithZone(zone) as! CircularCollectionViewLayoutAttributes
    copiedAttributes.anchorPoint = self.anchorPoint
    copiedAttributes.angle = self.angle
    return copiedAttributes
  }
}

class CircularCollectionViewLayout: UICollectionViewLayout{

  var fristPrsent = true
  let itmeSize = CGSize(width: 133, height: 173)
  var angleAtExtreme:CGFloat{
    return collectionView!.numberOfItemsInSection(0) > 0 ? -CGFloat(collectionView!.numberOfItemsInSection(0) - 1) * anglePerItem : 0
  }
    

  
  
  var angle:CGFloat{
    return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize().width - CGRectGetWidth(collectionView!.bounds))
  }
  
  var radius:CGFloat = 500 {
    didSet{
      invalidateLayout()
    }
  }
  var anglePerItem: CGFloat{
    return atan(itmeSize.width / radius)
  }
  
  override func collectionViewContentSize() -> CGSize {
    return CGSize(width: CGFloat(collectionView!.numberOfItemsInSection(0)) * self.itmeSize.width, height: CGRectGetHeight(collectionView!.bounds))
  }
  
  override class func layoutAttributesClass() -> AnyClass {
    return CircularCollectionViewLayoutAttributes.self
  }
  
  var attributesList = [CircularCollectionViewLayoutAttributes]()
  
  override func prepareLayout() {
    super.prepareLayout()
    if  fristPrsent{
        collectionView!.contentOffset.x = lastContentOffsetX
        fristPrsent = false
    }
    
    let theta = atan2(CGRectGetWidth(collectionView!.bounds) / 2 ,radius + (itmeSize.height / 2) - (CGRectGetHeight(collectionView!.bounds) / 2))
    let centerX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds) / 2.0)
    let anchorPointY = ((itmeSize.height / 2.0) + radius) / itmeSize.height
    
    var startIndex = 0
    var endIndex = collectionView!.numberOfItemsInSection(0) - 1
    
    if (angle < -theta){
      startIndex = Int(floor(((-theta - angle ) /  anglePerItem)))
    }
    
    endIndex = min(endIndex, Int(ceil((theta -  angle) / anglePerItem)))
    
    if endIndex < startIndex{
      startIndex = 0
      endIndex  = 0
    }
    
    attributesList = (startIndex...endIndex).map{
      (i) -> CircularCollectionViewLayoutAttributes in
      let attributes = CircularCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
      attributes.size = self.itmeSize
      attributes.center = CGPoint(x: centerX, y: CGRectGetMidY(self.collectionView!.bounds))
      attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
      attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
      return attributes
    }
  }
  
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return attributesList
  }
  
  override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
    return attributesList[indexPath.row]
  }
  
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    return true
  }
  
  
}
