//
//  AirQualityDetailViewController.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/29/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import UIKit


class AirQualityDetailViewController: UIViewController {
    var smallDustValue = Double()
    var coValue = Double()
    var noValue = Double()
    var so2Value = Double()
    var ozValue = Double()
    var dustValue = Double()
    
    @IBOutlet weak var smallDustStatusImage: UIImageView!
    @IBOutlet weak var coStatusImage: UIImageView!
    @IBOutlet weak var noStatusImage: UIImageView!
    @IBOutlet weak var so2StatusImage: UIImageView!
    @IBOutlet weak var ozStatusImage: UIImageView!
    @IBOutlet weak var dustStatusImage: UIImageView!
    
    @IBOutlet weak var smallDustStatus: UILabel!
    @IBOutlet weak var coStatus: UILabel!
    @IBOutlet weak var noStatus: UIImageView!
    @IBOutlet weak var so2Status: UILabel!
    @IBOutlet weak var ozStatus: UILabel!
    @IBOutlet weak var dustStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
