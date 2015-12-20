//
//  SetingViewController.swift
//  25分
//
//  Created by blues on 15/12/20.
//  Copyright © 2015年 blues. All rights reserved.
//

import UIKit

class SetingViewController: UIViewController {
    
    var collectionVC:CollectionViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionVC = self.storyboard?.instantiateViewControllerWithIdentifier("collection") as! CollectionViewController

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func giveUpMusic(sender: AnyObject) {
        self.presentViewController(collectionVC, animated: true, completion: nil)
    }
    
    @IBAction func Abutton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func Bbutton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
