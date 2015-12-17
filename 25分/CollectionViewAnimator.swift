//
//  CollectionViewAnimator.swift
//  25分
//
//  Created by blues on 15/12/16.
//  Copyright © 2015年 blues. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewAnimator:NSObject, UIViewControllerAnimatedTransitioning{
    
    var presenting = true;
    var duration = 0.5
    var spring:CGFloat = 0.5
    var springV:CGFloat = 0.2
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        //set label
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        
        let containerView = transitionContext.containerView()!
        let containerFrame = transitionContext.containerView()!.frame
        
        let viewForAnimation = presenting ? toView! : fromView!
        let orignViewAniamtion = presenting ? fromVC.view : toVC.view
        
        let animationVC = presenting ? toVC  : fromVC
        
        
        let initViewHight = CGRectGetHeight(transitionContext.finalFrameForViewController(animationVC))
        
        let initViewframe = CGRect(x: 0, y: CGRectGetHeight(containerFrame), width: CGRectGetWidth(containerFrame), height: initViewHight)
        
        if presenting{
            viewForAnimation.frame = initViewframe
            containerView.addSubview(viewForAnimation)
        }
        
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: spring, initialSpringVelocity: springV, options: .TransitionCurlUp, animations: { () in
            if(self.presenting){
                viewForAnimation.frame = transitionContext.finalFrameForViewController(animationVC)
                orignViewAniamtion.frame.origin.y -= CGRectGetHeight(viewForAnimation.bounds)
            }else{
                viewForAnimation.frame = initViewframe
                orignViewAniamtion.center.y += CGRectGetHeight(viewForAnimation.bounds)
            }
            }){ h in
                if !self.presenting {
                    viewForAnimation.removeFromSuperview()
                }
                transitionContext.completeTransition(true)
            }
        
    }
}