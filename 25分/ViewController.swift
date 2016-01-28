//
//  ViewController.swift
//  25分
//
//  Created by blues on 15/12/11.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    let tDelegate = BubbleTransiton()
    
    
    @IBOutlet var dataView: UIView!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var voiceButton: UIButton!
    @IBOutlet weak var labelView: UIView!
    
    let myTimer = Timer.shareInstance
    
    
    @IBAction func swipeDown(sender: AnyObject) {
        let selectVC = self.storyboard!.instantiateViewControllerWithIdentifier("selectTimeVC")
        selectVC.modalPresentationStyle = .Custom
        selectVC.transitioningDelegate = transitionDelegate
        self.view.addSubview(selectVC.view)
//        self.presentViewController(selectVC, animated: true, completion: nil)
    }
    @IBAction func swipeUp(sender: AnyObject) {
        presentColorController()
    }
    
    @IBAction func presentCollectionViewController(sender: AnyObject) {
        //give up 
        Timer.shareInstance.timerWillState = timerState.giveUp
        Timer.shareInstance.timerWillAction()
        
        //present
       let setingVC = self.storyboard?.instantiateViewControllerWithIdentifier("SetingVC") as! SetingViewController
        setingVC.modalTransitionStyle = .FlipHorizontal
        
        self.presentViewController(setingVC, animated: true, completion: nil)
    }
    
    @IBAction func tabSetingButton(sender: AnyObject) {
        
    }
    
    @IBAction func keepSlience(sender: AnyObject) {
        voice = !voice
        switchVoiceButton(voice)
        voiceModeSwich(voice)
    }
    
    
    
    @IBAction func touchUpTimerButton(sender: AnyObject) {
        myTimer.timerWillAction()
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSThread.sleepForTimeInterval(1.0)
        // Do any additional setup after loading the view, typically from a nib.
        timerLabel.text = formatToDisplayTime(myTimer.fireTime)
        self.myTimer.delegate = self
        
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        self.becomeFirstResponder()
        
        voice = NSUserDefaults.standardUserDefaults().boolForKey(voiceKey)
        switchVoiceButton(voice)
        voiceModeSwich(voice)
        initSeting()
        
        NSBundle.mainBundle().loadNibNamed("LabelBackgroundView", owner: self, options: nil)
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().resignFirstResponder()
        self.resignFirstResponder()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func remoteControlReceivedWithEvent(event: UIEvent?) {
        if event == nil {
           return
        }
        
        if event?.type == UIEventType.RemoteControl{
            switch(event!.subtype){
            case .RemoteControlPlay:
                backgroundMusicPlayer.play()
            case .RemoteControlPause:
                backgroundMusicPlayer.pause()
            default:
                print(event!.subtype)
            }
        
        }
    }
    
}

extension ViewController{
    func switchVoiceButton(voice:Bool){
        if voice {
            voiceButton.setTitle("静音", forState: .Normal)
        }else{
            voiceButton.setTitle("音乐", forState: .Normal)
        }
    }
    
    func presentColorController(){
        let colorVC = self.storyboard!.instantiateViewControllerWithIdentifier("colorVC") as! ColorViewController
        //1 set modal PreStyle
        colorVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        colorVC.labelView = self.labelView
        //2 set transition delegate
        colorVC.transitioningDelegate = transitionDelegate
        self.presentViewController(colorVC, animated: true, completion: nil)
    }
}

extension ViewController:timerDelegate{
    func timerStateToController(timerWillState: String){
        switch timerWillState{
        case timerState.start:
            self.timerLabel.text = formatToDisplayTime(self.myTimer.fireTime)
            self.timerButton.setImage(UIImage(named: "startButton"), forState: .Normal)
        case timerState.giveUp:
            self.timerButton.setImage(UIImage(named: "giveUpButton"), forState: .Normal)
        case timerState.workingComplete:
            self.timerButton.setImage(UIImage(named: "restButton"), forState: .Normal)
        case timerState.rest:
            self.timerButton.setImage(UIImage(named: "restButton"), forState: .Normal)
        case timerState.restComplete:
            self.timerButton.setImage(UIImage(named: "workButton"), forState: .Normal)
        default:
            print("error : \(timerWillState)")
        }
    }
    
    func updateingTime(currentTime:Int){
        timerLabel.text = formatToDisplayTime(currentTime)
    }
}



