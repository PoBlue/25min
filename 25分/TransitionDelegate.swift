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
    
    let collectionAnimator = CollectionViewAnimator()
    let selectTimeAnimator = SelectTimeAnimator()
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch presented{
        case is CollectionViewController:
            collectionAnimator.presenting = true
            return collectionAnimator
        case is SelectViewController:
            selectTimeAnimator.presenting = true
            return selectTimeAnimator
        default:
            print("Error no animater")
        }
        return nil
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch dismissed{
        case is CollectionViewController:
            collectionAnimator.presenting = false
            return collectionAnimator
        case is SelectViewController:
            selectTimeAnimator.presenting = false
            return selectTimeAnimator
        default:
            print("Error no animater")
        }
        return nil
    }
    
    //present size
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        let customPresent = CustomPresent.init(presentedViewController: presented,presentingViewController: presenting)
        
        switch presented{
        case is CollectionViewController:
            customPresent.top = false
        case is SelectViewController:
            customPresent.top = true
        default:
            print("Error no animater")
        }
        
        return customPresent
    }
}