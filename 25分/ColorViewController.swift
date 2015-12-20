//
//  ColorViewController.swift
//  25分
//
//  Created by blues on 15/12/20.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        initView()
    }
    
    override func viewDidAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

extension ColorViewController{
    func initView(){
        let viewH = CGRectGetHeight(view.bounds)
        let viewW = CGRectGetWidth(view.bounds)
        let viewHd3 = CGRectGetWidth(view.bounds) / 3
        
        let inter = viewHd3 / 10
        let btnW = viewHd3 * 8 / 10
        let btnH = btnW
        

        let btn1 = UIButton(frame: CGRect(x: inter, y: inter, width: btnW, height: btnH))
        let btn2 = UIButton(frame: CGRect(x: (viewW / 2) - (btnW / 2), y: inter, width: btnW, height: btnH))
        let btn3 = UIButton(frame: CGRect(x: viewW - (btnW + inter), y: inter, width: btnW, height: btnH))
        
        let randomBtn = UIButton()
        randomBtn.center = CGPoint(x: viewW / 2, y: viewH * 3 / 4)
        randomBtn.bounds = CGRect(x: 0, y: 0, width: btnW, height: viewH / 4)
        
        randomBtn.setTitle("random", forState: .Normal)
        randomBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        
        btn1.backgroundColor = UIColor.blueColor()
        btn2.backgroundColor = UIColor.brownColor()
        btn3.backgroundColor = UIColor.yellowColor()
        
        btn1.layer.cornerRadius = btnW / 8
        btn2.layer.cornerRadius = btnW / 8
        btn3.layer.cornerRadius = btnW / 8
        
        setBtnShadow(btn1)
        setBtnShadow(btn2)
        setBtnShadow(btn3)
        
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        self.view.addSubview(btn3)
        self.view.addSubview(randomBtn)
    }
    
    func setBtnShadow(btn:UIButton){
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowOpacity = 0.9
    }
}
