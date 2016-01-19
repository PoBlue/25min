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
        
        let tapBtn = sender as! UIButton
        let (bgmArray,musicSetObj) = btnArrayAndObj(tapBtn)
        self.collectionVC.bgmArray = bgmArray
        self.collectionVC.musicSet = musicSetObj
        CircularCollectionViewLayout.musicSet = musicSetObj
        lastContentOffsetX = musicSetObj.lastContentOffset
        collectionViewPresent(tapBtn)
    }
    
    @IBAction func setingTap(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension SetingViewController{
    
    func btnArrayAndObj(tapButton:UIButton) -> ([Bgm] , MusicSet){
        switch tapButton.titleLabel!.text!{
        case "休息提醒":
            return (restFinArray,restFinMusicSet)
        case "工作提醒":
            return (winArray,winMusicSet)
        case "休息音乐":
            return (restArray,restMusicSet)
        case "主音乐":
            return (advArray,mainMusicSet)
        default:
            print("error in btnArrayAndObj Function")
            return ([Bgm](),MusicSet(path: "nil",musicKey: "nil"))
        }
    }
    
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
