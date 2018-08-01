//
//  3DaysForecastCellController.swift
//  WeatherNow
//
//  Created by macmini on 22/07/2018.
//  Copyright © 2018 Kaho. All rights reserved.
//

import Foundation
import UIKit

class ForecastDayTableViewCell: UITableViewCell {
//    @IBOutlet var weatherConditionImageView: UIImageView!
//    @IBOutlet var weekdayLabel: UILabel!
//    @IBOutlet var weatherConditionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
