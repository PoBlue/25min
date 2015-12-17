//
//  transitionDelegate.swift
//  25分
//
//  Created by blues on 15/12/16.
//  Copyright © 2015年 blues. All rights reserved.
//

import Foundation
import UIKit

class TransitionDelegate:NSObject,UIViewControllerTransitioningDelegate {
    
    let animator = CollectionViewAnimator()
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = true
        return animator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = false
        return animator
    }
    
    //present size
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        let customPresent = CustomPresent.init(presentedViewController: presented,presentingViewController: presenting)
        return customPresent
    }
}