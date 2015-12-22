//
//  BubbleTransition.swift
//  25分
//
//  Created by blues on 15/12/21.
//  Copyright © 2015年 blues. All rights reserved.
//

import Foundation
import BubbleTransition

class BubbleTransiton:NSObject,UIViewControllerTransitioningDelegate {
    
    let transition = BubbleTransition()
    var tapButton = UIButton()
    static let shareInstance = BubbleTransiton()
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = tapButton.center
        transition.bubbleColor  = UIColor(red: 21 / 256, green: 21 / 256, blue: 21 / 256, alpha: 1.0)
        
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = tapButton.center
        transition.bubbleColor  = UIColor(red: 21 / 256, green: 21 / 256, blue: 21 / 256, alpha: 1.0)
        
        return transition
    }
}