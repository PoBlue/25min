//
//  SelectViewController.swift
//  25分
//
//  Created by blues on 15/12/18.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
