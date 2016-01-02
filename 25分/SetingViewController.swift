//
//  SetingViewController.swift
//  25分
//
//  Created by blues on 15/12/20.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit

class SetingViewController: UIViewController ,UIViewControllerTransitioningDelegate{
    
    var collectionVC:CollectionViewController!
    let tDelegate = BubbleTransiton()
    
    @IBOutlet weak var mainMusicBtn: UIButton!
    @IBOutlet weak var restMusicBtn: UIButton!
    @IBOutlet weak var winMusicBtn: UIButton!
    @IBOutlet weak var restFinishMusicBtn: UIButton!

    @IBOutlet weak var setingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        
    }

    
    @IBAction func musicBtnTap(sender: AnyObject) {
        self.collectionVC = self.storyboard?.instantiateViewControllerWithIdentifier("collection") as! CollectionViewController
        let button = sender as! UIButton
        collectionViewPresent(button)
    }
    
    @IBAction func setingTap(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension SetingViewController{
    
    func collectionViewPresent(tapButton:UIButton){
        tDelegate.tapButton = tapButton
        collectionVC.transitioningDelegate = tDelegate
        collectionVC.modalPresentationStyle = .Custom
        self.presentViewController(collectionVC, animated: true, completion: nil)
    }
    
    func initView(){
        
        makeRadiusBtn(setingButton, borderColor: UIColor.whiteColor().CGColor)
        makeRadiusBtn(mainMusicBtn, borderColor: UIColor.yellowColor().CGColor)
        makeRadiusBtn(restMusicBtn, borderColor: UIColor.yellowColor().CGColor)
        makeRadiusBtn(winMusicBtn, borderColor: UIColor.yellowColor().CGColor)
        makeRadiusBtn(restFinishMusicBtn, borderColor: UIColor.yellowColor().CGColor)
        
        
    }
    
    func makeRadiusBtn(btn:UIButton,borderColor:CGColor){
        let btnH:CGFloat = CGRectGetHeight(btn.bounds)
        btn.layer.borderColor = borderColor
        btn.layer.borderWidth = 1.0
        btn.layer.cornerRadius = btnH / 2
    }
}
