//
//  ViewController.swift
//  25分
//
//  Created by blues on 15/12/11.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    var countingTime = false
    let fireTime = 60 * 25
    var currentTime = 60 * 25
    var time:NSTimer!
    
    
    @IBAction func touchUpTimerButton(sender: AnyObject) {
        if !countingTime {
            self.time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeUp:", userInfo: nil, repeats: true)
            countingTime = true
            timerButton.setTitle("放弃", forState: .Normal)
        }else{
            time.invalidate()
            currentTime = fireTime
            timerLabel.text = "25:00"
            countingTime = false
            timerButton.setTitle("开始", forState: .Normal)
        }
    }
    
    func timeUp(timer:NSTimer) -> Void{
        if currentTime > 0{
            let min = currentTime / 60
            let second = currentTime % 60
            let time = String(format: "%02d:%02d", arguments: [min,second])
            timerLabel.text = time
            
            currentTime--
            return
        }else{
            timer.invalidate()
            timerLabel.text = "00:00"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

