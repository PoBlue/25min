//
//  ColorViewController.swift
//  25分
//
//  Created by blues on 15/12/20.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit
import RandomColorSwift


class ColorViewController: UIViewController {

    @IBOutlet weak var lightColorBtn: UIButton!
    @IBOutlet weak var midColorBtn: UIButton!
    @IBOutlet weak var heavyColorBtn: UIButton!
    @IBOutlet weak var randomBtn: UIButton!
    
    var labelView:UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func lightBtnTap(sender: AnyObject) {
        print("light")
        self.labelView.backgroundColor = lightColorBtn.backgroundColor
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func midBtnTap(sender: AnyObject) {
        self.labelView.backgroundColor = midColorBtn.backgroundColor
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func heavyBtnTap(sender: AnyObject){
        self.labelView.backgroundColor = heavyColorBtn.backgroundColor
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func randomBtnTap(sender: AnyObject) {
        randomAndSetColor()
    }

}

extension ColorViewController{
    func initView(){
        makeRadiusBtn(randomBtn, borderColor: UIColor.yellowColor().CGColor)
    }
    
    func setBtnShadow(btn:UIButton){
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowOpacity = 0.9
        
    }
    
    func randomAndSetColor(){
        let lightColor = randomColor(hue: .Random, luminosity: .Bright)
        let midColor = randomColor(hue: .Random, luminosity: .Light)
        let heavyColor = randomColor(hue: .Random, luminosity: .Dark)
        
        lightColorBtn.backgroundColor = lightColor
        midColorBtn.backgroundColor = midColor
        heavyColorBtn.backgroundColor = heavyColor
    }
    
}
