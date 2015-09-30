//
//  WaterViewController.swift
//  BusanApp
//
//  Created by chansung on 9/30/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import UIKit

class WaterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var provinceName: UILabel!
  
    
    var waterDataSet: [WaterData] = [WaterData]()
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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.waterDataSet.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : WaterViewCell = tableView.dequeueReusableCellWithIdentifier("WaterCell") as! WaterViewCell
        print("dddd")
        cell.streetName.text = waterDataSet[indexPath.row].inspecArea
        cell.result.text = waterDataSet[indexPath.row].result
        let chemicalElement = waterDataSet[indexPath.row].chemicalElements
        cell.gernalGerm.text = "\(chemicalElement[5])"
        cell.allGerm.text = "\(chemicalElement[6])"
        cell .partGerm.text  =    "\(chemicalElement[7])"
        
    
        return cell
    }

}
