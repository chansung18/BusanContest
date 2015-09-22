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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphView.addLine([10, 4, 1, 5, 2, 6, 8, 2, 5, 12, 3])
        graphView.x.grid.visible = false
        graphView.y.grid.visible = false
        graphView.x.labels.visible = false
        graphView.y.labels.visible = false
        
        graphView.backgroundColor = UIColor.clearColor()
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

