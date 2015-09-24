//
//  ViewController.swift
//  BusanApp
//
//  Created by chansung on 9/16/15.
//  Copyright (c) 2015 Eunkyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var graphView: LineChart!
//    @IBOutlet weak var radioGaugePoint: UIButton!
//    @IBOutlet weak var dustGaugePoint: UIButton!
//    @IBOutlet weak var waterGaugePoint: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphView.addLine([10, 4, 1, 5, 2, 6, 8, 2, 5, 12, 3])
        graphView.x.grid.visible = false
        graphView.x.labels.visible = false
        graphView.y.labels.visible = false
        graphView.x.axis.visible = false;
        graphView.y.axis.visible = false;
        
        graphView.backgroundColor = UIColor.clearColor()

        UIView.animateWithDuration(0.8, delay: 0, options: UIViewAnimationOptions.CurveEaseIn
            , animations: { () -> Void in
//                        self.radioGaugePoint.transform = CGAffineTransformRotate(self.radioGaugePoint.transform, 2.0)
//                        self.dustGaugePoint.transform = CGAffineTransformRotate(self.dustGaugePoint.transform, 2.5)
//                        self.waterGaugePoint.transform = CGAffineTransformRotate(self.waterGaugePoint.transform, 1.5)

            }, completion: nil)
     }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

