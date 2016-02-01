//
//  TodayViewController.swift
//  25min
//
//  Created by blues on 16/1/31.
//  Copyright © 2016年 blues. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var midBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    
    @IBAction func btnTouch(btn:UIButton){
        
        //save date
//        let groupKey = "group.value"
//        let myContainShare = NSUserDefaults.init(suiteName: groupKey)
//        
//        let a  = myContainShare?.integerForKey("test")
        
        
        //open url
        let url = NSURL(string: "25min://helloWorld")
        self.extensionContext?.openURL(url!, completionHandler: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.preferredContentSize = CGSizeMake(320, 60)
        makeRadiusBtn(midBtn, borderColor: UIColor.yellowColor().CGColor)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
}

extension TodayViewController{
    func makeRadiusBtns(btns:[UIButton]){
        
        for i in 0..<btns.count{
            makeRadiusBtn(btns[i], borderColor: UIColor.greenColor().CGColor)
        }
    }
    
    func makeBorderBtn(btn:UIButton,borderColor:CGColor,radious:CGFloat){
        btn.layer.borderColor = borderColor
        btn.layer.borderWidth = 1.0
        btn.layer.cornerRadius = radious
    }

    func makeRadiusBtn(btn:UIButton,borderColor:CGColor){
        let btnH:CGFloat = CGRectGetHeight(btn.bounds)
        makeBorderBtn(btn, borderColor: borderColor, radious: btnH / 2)
    }
}
