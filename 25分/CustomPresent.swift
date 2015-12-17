//
//  CustomPresent.swift
//  25分
//
//  Created by blues on 15/12/16.
//  Copyright © 2015年 blues. All rights reserved.
//

import Foundation
import UIKit

class CustomPresent: UIPresentationController {
    override func frameOfPresentedViewInContainerView() -> CGRect {
        
        return CGRectMake(0, 2 * CGRectGetHeight(containerView!.bounds) / 3, CGRectGetWidth(containerView!.bounds), 1 * CGRectGetHeight(containerView!.bounds) / 3)
    }
    
    
}
