//
//  weatherTableViewCell.swift
//  downloadFiles
//
//  Created by Tejashree on 24/03/19.
//  Copyright © 2019 Tejashree. All rights reserved.
//

import UIKit

class weatherTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityDetails: UILabel!
    @IBOutlet weak var weatherSymbol: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDetails: UILabel!
    @IBOutlet weak var temperatureDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
