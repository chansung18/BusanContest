//
//  RadioDetailViewController.swift
//  BusanApp
//
//  Created by Chansung, Park on 9/28/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import UIKit

class RadioDetailViewController: UIViewController {
    
    @IBOutlet weak var areaLabel: UILabel!
    
    var currentRadioValue: Int?
    var beforeRadioValue: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
