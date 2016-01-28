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
    
    
    var dimingView:UIView!
    var top = true
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        
        if top{
            return CGRectMake(0, 0, CGRectGetWidth(containerView!.bounds), 1 * CGRectGetHeight(containerView!.bounds) / 4)
        }
        
        return CGRectMake(0, 2 * CGRectGetHeight(containerView!.bounds) / 3, CGRectGetWidth(containerView!.bounds), 1 * CGRectGetHeight(containerView!.bounds) / 3)
    }
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        self.dimingView = UIView()
        self.dimingView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        self.dimingView.alpha = 0
    }
    
    func dimingViewTap(){
        presentedViewController.modalPresentationStyle = .Custom
        presentedViewController.transitioningDelegate = transitionDelegate
        
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func presentationTransitionWillBegin() {
        //add gesture
        let touchUpGecture = UITapGestureRecognizer(target: self, action: "dimingViewTap")
        var swipeGesture:UISwipeGestureRecognizer!
        if top{
            swipeGesture = UISwipeGestureRecognizer(target: self, action: "dimingViewTap")
            swipeGesture.direction = UISwipeGestureRecognizerDirection.Up
        }else{
            swipeGesture = UISwipeGestureRecognizer(target: self, action: "dimingViewTap")
            swipeGesture.direction = UISwipeGestureRecognizerDirection.Down
        }
        self.dimingView.addGestureRecognizer(touchUpGecture)
        self.dimingView.addGestureRecognizer(swipeGesture)
       
        //transition
        let containerView = self.containerView!
        self.dimingView.frame = containerView.bounds
        self.dimingView.alpha = 0
        containerView.insertSubview(self.dimingView, atIndex: 0)
        
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({
            i  in
            self.dimingView.alpha = 1.0
            }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(completed: Bool) {
        if(!completed){
            self.dimingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({
            i in
            self.dimingView.alpha = 0.0
            }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        if(completed){
            self.dimingView.removeFromSuperview()
        }
    }
    
}
