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
    @IBOutlet weak var areLabel: UILabel!
    
    @IBOutlet weak var smallDustStatusImage: UIImageView!
    @IBOutlet weak var coStatusImage: UIImageView!
    @IBOutlet weak var noStatusImage: UIImageView!
    @IBOutlet weak var so2StatusImage: UIImageView!
    @IBOutlet weak var ozStatusImage: UIImageView!
    @IBOutlet weak var dustStatusImage: UIImageView!
    
    @IBOutlet weak var smallDustStatus: UILabel!
    @IBOutlet weak var coStatus: UILabel!
    @IBOutlet weak var noStatus: UIImageView!
    @IBOutlet weak var noStatus1: UILabel!
    @IBOutlet weak var so2Status: UILabel!
    @IBOutlet weak var ozStatus: UILabel!
    @IBOutlet weak var dustStatus: UILabel!

    @IBOutlet weak var airDustValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if( smallDustValue < 15.0)
        {
            smallDustStatus.text = "좋음"
            smallDustStatusImage.image = UIImage(named: "greencircle")
        }
        else if( smallDustValue < 55.0)
        {
            smallDustStatus.text = "보통"
            smallDustStatusImage.image = UIImage(named: "yellowcircle")
        }
        else{
            smallDustStatus.text = "나쁨"
            smallDustStatusImage.image = UIImage(named: "redcircle")
        }
        
        if( coValue < 7.0)
        {
            coStatus.text = "좋음"
            coStatusImage.image = UIImage(named: "greencircle")
        }
        else if( coValue < 11.0)
        {
            coStatus.text = "보통"
            coStatusImage.image = UIImage(named: "yellowcircle")
        }
        else{
            coStatus.text = "나쁨"
            coStatusImage.image = UIImage(named: "redcircle")
        }
        
        if( noValue < 0.02)
        {
            noStatus1.text = "좋음"
            noStatusImage.image = UIImage(named: "greencircle")
        }
        else if( noValue < 0.03)
        {
            noStatus1.text = "보통"
            noStatusImage.image = UIImage(named: "yellowcircle")
        }
        else{
            noStatus1.text = "나쁨"
            noStatusImage.image = UIImage(named: "redcircle")
        }
        
        if( so2Value < 2.0)
        {
            so2Status.text = "좋음"
            so2StatusImage.image = UIImage(named: "redcircle")
        }
        else if( coValue < 5.0)
        {
            so2Status.text = "보통"
            so2StatusImage.image = UIImage(named: "yellowcircle")
        }
        else{
            so2Status.text = "나쁨"
            so2StatusImage.image = UIImage(named: "redcircle")
        }
        
        if( ozValue < 0.03)
        {
            ozStatus.text = "좋음"
            ozStatusImage.image = UIImage(named: "greencircle")
        }
        else if( ozValue < 0.09)
        {
            ozStatus.text = "보통"
            ozStatusImage.image = UIImage(named: "yellowcircle")
        }
        else{
            ozStatus.text = "나쁨"
            ozStatusImage.image = UIImage(named: "redcircle")
        }
        
        if( dustValue < 30)
        {
            dustStatus.text = "좋음"
            dustStatusImage.image = UIImage(named: "greencircle")
        }
        else if( dustValue < 80)
        {
            dustStatus.text = "보통"
            dustStatusImage.image = UIImage(named: "yellowcircle")
        }
        else{
            dustStatus.text = "나쁨"
            dustStatusImage.image = UIImage(named: "redcircle")
        }
        airDustValue.text = "\(dustValue) PM"
        
        
        
        
        
        
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
