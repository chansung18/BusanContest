//
//  AirTableViewCell.swift
//  BusanApp
//
//  Created by chansung on 9/30/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import UIKit

class AirTableViewCell: UITableViewCell {
    @IBOutlet weak var placeName: UILabel!

    @IBOutlet weak var smallDustStatusImage: UIImageView!
    @IBOutlet weak var dustStatusImage: UIImageView!
    @IBOutlet weak var coStatusImage: UIImageView!
    @IBOutlet weak var noStatusImage: UIImageView!
    @IBOutlet weak var ozStatusImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
