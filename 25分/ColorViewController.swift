//
//  ColorViewController.swift
//  25分
//
//  Created by blues on 15/12/20.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var lightColorBtn: UIButton!
    @IBOutlet weak var midColorBtn: UIButton!
    @IBOutlet weak var heavyColorBtn: UIButton!
    @IBOutlet weak var randomBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidAppear(animated: Bool) {
        initView()
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
//        makeRadiusBtn(lightColorBtn, borderColor: lightColorBtn.backgroundColor!.CGColor)
//        makeRadiusBtn(midColorBtn, borderColor: midColorBtn.backgroundColor!.CGColor)
//        makeRadiusBtn(heavyColorBtn, borderColor: heavyColorBtn.backgroundColor!.CGColor)
        
        setBtnShadow(lightColorBtn)
        
        makeRadiusBtn(randomBtn, borderColor: UIColor.yellowColor().CGColor)
    }
    
    func setBtnShadow(btn:UIButton){
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowOpacity = 0.9
    }
}
