//
//  SelectViewController.swift
//  25分
//
//  Created by blues on 15/12/18.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {

    @IBOutlet weak var set10MinBtn: UIButton!
    @IBOutlet weak var set25MinBtn: UIButton!
    @IBOutlet weak var set45MinBtn: UIButton!
    
   
    var longPressing = false
    var datePicking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        addLongGesture(set10MinBtn)
        addLongGesture(set25MinBtn)
        addLongGesture(set45MinBtn)
    }
    
    func setTimerFiretime(sender:AnyObject){
        
        let btn = sender as! UIButton
        let time = getTimeFromText(btn.titleLabel!.text!)
        
        Timer.shareInstance.fireTime = time
        Timer.shareInstance.timerCurrentState = timerState.giveUp
        Timer.shareInstance.timerWillState = timerState.giveUp
        Timer.shareInstance.timerWillAction()
    }
    
    @IBAction func min10fireTimeSetup(sender: AnyObject) {
        setTimerFiretime(sender)
        dismissSelfController()
    }
    
    @IBAction func min25fireTimeSetup(sender: AnyObject) {
        setTimerFiretime(sender)
        dismissSelfController()
    }
    
    @IBAction func min45FireTimeSetup(sender: AnyObject) {
        setTimerFiretime(sender)
        dismissSelfController()
    }
    
    func dismissSelfController(){
        (self.parentViewController as! ContainerViewController).hideOrShowMenu(false, animated: true)
//        self.modalPresentationStyle = .Custom
//        self.transitioningDelegate = transitionDelegate
//        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension SelectViewController{
    func getTimeFromText(text:String) -> Int{
        let endIndex = text.endIndex.advancedBy(-1)
        let timeStr = text.substringToIndex(endIndex)
        let time = Int(timeStr)
        
        print(timeStr)
        print(Int(timeStr))
    
        if time == nil{
            print("time can not conver")
        }
        
        return time! * 60
    }
    func initView(){
        makeRadiusBtn(set10MinBtn,borderColor: UIColor(red: 23 / 256, green: 106 / 256, blue: 213 / 256, alpha: 1.0).CGColor)
        makeRadiusBtn(set25MinBtn,borderColor: UIColor(red: 237 / 256, green: 242 / 256, blue:  11 / 256, alpha: 1.0).CGColor)
        makeRadiusBtn(set45MinBtn,borderColor: UIColor(red: 11 / 256, green: 242 / 256, blue: 32 / 256, alpha: 1.0).CGColor)
    }
    
    func addLongGesture(view:UIView){
        let longpressG = UILongPressGestureRecognizer(target: self, action: "longPress:")
        view.addGestureRecognizer(longpressG)
    }
    
    func longPress(sender:AnyObject){
        let pressG = sender as! UILongPressGestureRecognizer
        let pressBtn = pressG.view as! UIButton
        if !datePicking{
            presentDatePickVC(pressBtn)
            datePicking = true
        }
    }
    
    func presentDatePickVC(pressBtn:UIButton){
        let dateVC = self.storyboard!.instantiateViewControllerWithIdentifier("datePView") as! DatePickViewController
        dateVC.timeBtn = pressBtn
        self.presentViewController(dateVC, animated: true, completion: nil)
    }
}
