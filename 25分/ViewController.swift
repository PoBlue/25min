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
    let fireTime = 9
    let myTimer = Timer()
    
    @IBAction func touchUpTimerButton(sender: AnyObject) {
        myTimer.timerWillAction(){
            (timerWillState:String) in
            switch timerWillState{
            case timerState.giveUp:
                print("giveUp")
            default:
                print("other \(timerWillState)")
                
            }
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timerLabel.text = formatToDisplayTime(fireTime)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -easy method
    


}

