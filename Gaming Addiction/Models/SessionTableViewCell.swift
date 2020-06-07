//
//  SessionTableViewCell.swift
//  Gaming Addiction
//
//  Created by Anish Kochhar on 06/06/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

// Custom Table View Cell
class SessionTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deviceLabel: UILabel!
    @IBOutlet weak var timeSpentLabel: UILabel!
    
    func setLabels(date: String, device: String, timeSpent: String) {
        dateLabel.text = date
        deviceLabel.text = device
        timeSpentLabel.text = timeSpent
    }
}
