//
//  CircularCollectionViewCell.swift
//  CircularCollectionView
//
//  Created by Rounak Jain on 10/05/15.
//  Copyright (c) 2015 Rounak Jain. All rights reserved.
//

import UIKit

class CircularCollectionViewCell: UICollectionViewCell {
  
  var imageName: String = "" {
    didSet {
      imageView!.image = UIImage(named: imageName)
    }
  }
  
  @IBOutlet weak var imageView: UIImageView?
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    contentView.layer.cornerRadius = 5
    contentView.layer.borderColor = UIColor.blackColor().CGColor
    contentView.layer.borderWidth = 1
    contentView.layer.shouldRasterize = true
    contentView.layer.rasterizationScale = UIScreen.mainScreen().scale
    contentView.clipsToBounds = true
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView!.contentMode = .ScaleAspectFill
  }
  
  override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
    super.applyLayoutAttributes(layoutAttributes)
    let circularlayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
    self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
    self.center.y += (circularlayoutAttributes.anchorPoint.y - 0.5) * CGRectGetHeight(self.bounds)
  }
}
