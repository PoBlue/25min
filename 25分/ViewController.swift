//
//  ViewController.swift
//  25分
//
//  Created by blues on 15/12/11.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit

class ViewController: UIViewController , timerDelegate{

    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var voiceButton: UIButton!
    let myTimer = Timer.shareInstance
    
    @IBOutlet weak var timeSelectSlider: UISlider!
    
    func voiceModeSwich(voiceMode:Bool){
        if voiceMode{
           voiceButton.setTitle("静音", forState: .Normal)
            if backgroundMusicPlayer != nil {
               backgroundMusicPlayer.play()
            }
           return
        }
        
        voiceButton.setTitle("开启声音", forState: .Normal)
        if (backgroundMusicPlayer != nil) {
            backgroundMusicPlayer.pause()
        }
    }
    
    @IBAction func selectingTime(sender: AnyObject) {
        let slider = sender as! UISlider
        myTimer.fireTime = Int(25 * 60 * slider.value)
        myTimer.restFireTime = Int(10 * 60 * slider.value)
        
        timerLabel.text = formatToDisplayTime(myTimer.fireTime)
    }
    
    @IBAction func keepSlience(sender: AnyObject) {
        voice = !voice
        voiceModeSwich(voice)
    }
    
    @IBAction func touchUpTimerButton(sender: AnyObject) {
        myTimer.timerWillAction()
    }
    
    
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timerLabel.text = formatToDisplayTime(myTimer.fireTime)
        self.myTimer.delegate = self
        
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        self.becomeFirstResponder()
        
        voice = !NSUserDefaults.standardUserDefaults().boolForKey(voiceKey)
        voiceModeSwich(voice)
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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -easy method
    


}

