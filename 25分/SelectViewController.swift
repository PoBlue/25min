//
//  SelectViewController.swift
//  25分
//
//  Created by blues on 15/12/18.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func min10fireTimeSetup(sender: AnyObject) {
        print("10 min")
        dismissSelfController()
    }
    
    @IBAction func min25fireTimeSetup(sender: AnyObject) {
        print("25 min")
        dismissSelfController()
    }
    
    @IBAction func min45FireTimeSetup(sender: AnyObject) {
        print("45 min")
        dismissSelfController()
    }
    
    func dismissSelfController(){
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = transitionDelegate
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
