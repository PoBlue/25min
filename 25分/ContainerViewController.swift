//
//  DatePickViewController.swift
//  25分
//
//  Created by blues on 16/1/28.
//  Copyright © 2016年 blues. All rights reserved.
//

import Foundation
import UIKit

class ContainerViewController: UIViewController ,UIScrollViewDelegate {
    
    @IBOutlet weak var topView: UIView!
    private var mainVC : ViewController?
    var topVC : SelectViewController?
    @IBOutlet weak var scrollView: UIScrollView!
    
    var showingMenu = false
    var showingColor = false
    
    
    override func viewDidLayoutSubviews() {
        hideOrShowMenu(showingMenu, animated: false)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mainVC"{
            let mainVC = segue.destinationViewController as? ViewController
            self.mainVC = mainVC
        }
        
        if segue.identifier == "topVC"{
            let topVC = segue.destinationViewController as? SelectViewController
            self.topVC = topVC
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentSize.height == 0{
            return
        }
        
        let menuOffsetY = scrollView.contentSize.height - CGRectGetHeight(scrollView.frame)
        scrollView.pagingEnabled = scrollView.contentOffset.y < menuOffsetY
//        scrollView.bounces = scrollView.contentOffset.y >= menuOffsetY
        
        let boundOffset : CGFloat = 80
        if scrollView.contentOffset.y > (menuOffsetY + boundOffset){
            presentColorController()
        }
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let topOffsetY = CGRectGetHeight(topView.bounds)
        showingMenu = !CGPointEqualToPoint(scrollView.contentOffset, CGPoint(x: 0, y: topOffsetY))
        scrollView.bounces = !showingMenu
        
    }
}

extension ContainerViewController{
func presentColorController(){
    cancelScroll()
    
    let colorVC = self.storyboard!.instantiateViewControllerWithIdentifier("colorVC") as! ColorViewController
    //1 set modal PreStyle
    colorVC.modalPresentationStyle = UIModalPresentationStyle.Custom
    colorVC.labelView = self.mainVC!.labelView
    //2 set transition delegate
    colorVC.transitioningDelegate = transitionDelegate
    self.presentViewController(colorVC, animated: true, completion: nil)
    }
    func cancelScroll(){
        scrollView.scrollEnabled = false
        scrollView.scrollEnabled = true
    }
    
func hideOrShowMenu(show: Bool, animated: Bool) {
    let topOffsetY = CGRectGetHeight(topView.bounds)
    scrollView.setContentOffset(show ? CGPointZero : CGPointMake(0, topOffsetY), animated: animated)
    
    showingMenu = show
    scrollView.bounces = !showingMenu
}
}