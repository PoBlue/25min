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
    
   
    var datePickVC:DatePickViewController!
    var longPressing = false
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        addLongGesture(set10MinBtn)
        addLongGesture(set25MinBtn)
        addLongGesture(set45MinBtn)
        self.datePickVC = self.storyboard!.instantiateViewControllerWithIdentifier("datePickVC") as! DatePickViewController
    }
    
    func setTimerFiretime(time:Int){
        Timer.shareInstance.fireTime = time
        Timer.shareInstance.timerCurrentState = timerState.giveUp
        Timer.shareInstance.timerWillState = timerState.giveUp
        Timer.shareInstance.timerWillAction()
    }
    
    @IBAction func min10fireTimeSetup(sender: AnyObject) {
        setTimerFiretime(10 * 60)
        dismissSelfController()
    }
    
    @IBAction func min25fireTimeSetup(sender: AnyObject) {
        setTimerFiretime(25 * 60)
        dismissSelfController()
    }
    
    @IBAction func min45FireTimeSetup(sender: AnyObject) {
        setTimerFiretime(45 * 60)
        dismissSelfController()
    }
    
    func dismissSelfController(){
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = transitionDelegate
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension SelectViewController{
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
        print("longPress \(i)")
        i = i + 1
    }
}
