//
//  DownloadTableViewCell.swift
//  downloadFiles
//
//  Created by Tejashree on 23/03/19.
//  Copyright © 2019 Tejashree. All rights reserved.
//

import UIKit

class DownloadTableViewCell: UITableViewCell {

    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var downloadPercent: UILabel!
    @IBOutlet weak var downloadProgress: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
