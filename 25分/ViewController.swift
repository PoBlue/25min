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
    let myTimer = Timer.shareInstance
    
    @IBAction func touchUpTimerButton(sender: AnyObject) {
        myTimer.timerWillAction()
    }
    
    func timerStateToController(timerWillState: String){
        print("timerWillState\(timerWillState)")
        switch timerWillState{
        case timerState.start:
            timerLabel.text = formatToDisplayTime(myTimer.fireTime)
            timerButton.setTitle(timerState.start, forState: .Normal)
        case timerState.giveUp:
            timerButton.setTitle(timerState.giveUp, forState: .Normal)
        case timerState.workingComplete:
            timerButton.setTitle(timerState.workingComplete, forState: .Normal)
        case timerState.rest:
            timerButton.setTitle(timerState.rest, forState: .Normal)
        case timerState.restComplete:
            timerButton.setTitle(timerState.restComplete, forState: .Normal)
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
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -easy method
    


}

