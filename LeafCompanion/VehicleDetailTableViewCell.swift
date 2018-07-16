//
//  VehicleDetailTableViewCell.swift
//  LeafCompanion
//
//  Created by Matthew Mohrman on 5/15/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import UIKit

class VehicleDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    enum LabelKey: String {
        case title
        case value
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
