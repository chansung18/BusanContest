//
//  WaterViewTable.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/30/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//
import UIKit

class WaterViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var streetName: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var gernalGerm: UILabel!
    @IBOutlet weak var allGerm: UILabel!
    @IBOutlet weak var partGerm: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
