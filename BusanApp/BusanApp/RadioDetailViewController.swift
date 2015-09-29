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
    @IBOutlet weak var oneHourRadio: UILabel!
    @IBOutlet weak var currentRadio: UILabel!
    @IBOutlet weak var emoticonView: UIImageView!
    @IBOutlet weak var oneHourLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    
    var currentRadioValue = 0.0
    var beforeRadioValue = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
   

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setDataValue(){
        print("ccc -> \(currentRadioValue), bbbbb-> \(beforeRadioValue)")
        oneHourRadio.text = ("\(beforeRadioValue)")// \n uSv/h")
        if (beforeRadioValue < 0.03){
            oneHourLabel.text = "아주좋음"
        }
        else if (beforeRadioValue < 0.1){
            oneHourLabel.text = "좋음"
        }
        else if (beforeRadioValue < 0.3){
            oneHourLabel.text = "보통"
        }
        else if (beforeRadioValue < 0.5){
            oneHourLabel.text = "오염간주"
        }
        else if (beforeRadioValue < 0.8){
            oneHourLabel.text = "선량한도"
        }
        else if (beforeRadioValue < 1){
            oneHourLabel.text = "귀가조치"
        }
        
        currentRadio.text = ("\(currentRadioValue)")// uSv/h")
        if (currentRadioValue < 0.03){
            currentLabel.text = "아주좋음"
        }
        else if (currentRadioValue < 0.1){
            currentLabel.text = "좋음"
        }
        else if (currentRadioValue < 0.3){
            currentLabel.text = "보통"
        }
        else if (currentRadioValue < 0.5){
            currentLabel.text = "오염간주"
        }
        else if (currentRadioValue < 0.8){
            currentLabel.text = "선량한도"
        }
        else if (currentRadioValue < 1){
            currentLabel.text = "귀가조치"
        }
        
        
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
