//
//  RadioTableViewCell.swift
//  BusanApp
//
//  Created by chansung on 9/25/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import UIKit

class RadioTableViewCell: UITableViewCell {

    @IBOutlet weak var gaugeImageView: UIImageView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var beforeLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
