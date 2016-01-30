//
//  DatePickViewController.swift
//  25分
//
//  Created by blues on 16/1/29.
//  Copyright © 2016年 blues. All rights reserved.
//

import UIKit

class DatePickViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var dateView: UIDatePicker!
    var timeBtn:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //24 hours setting
        dateView.locale = NSLocale(localeIdentifier: "NL")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func datePickerValueChange(sender: AnyObject) {
        let time = getMinFromDatePick()
        timeLabel.text = "\(time)分钟"
    }

    @IBAction func btnTouch(sender: AnyObject) {
        let btnT = sender as! UIButton
        let btnText = btnT.titleLabel!.text!
        switch btnText{
            case "确定" :
                yesFunc()
            case "取消" :
                noFunc()
        default:
            print("may be error in DatePickVC")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DatePickViewController{
    func yesFunc(){
        setBtnTime()
        dismissDateVC()
    }
    func noFunc(){
        dismissDateVC()
    }
    
    func dismissDateVC(){
        let containerVC = self.presentingViewController as! ContainerViewController
        containerVC.topVC!.datePicking = false
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setBtnTime(){
        let time = getMinFromDatePick()
        timeBtn?.setTitle("\(time)分", forState: .Normal)
    }
    
    func getMinFromDatePick() -> Int{
        return Int(dateView.date.timeIntervalSinceDate(dateView.minimumDate!) / 60)
    }
}
