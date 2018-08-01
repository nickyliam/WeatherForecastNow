//
//  CurrentWeatherViewModel.swift
//  WeatherNow
//
//  Created by macmini on 26/07/2018.
//  Copyright © 2018 Kaho. All rights reserved.
//

import Foundation
import UIKit

struct ForecastWeatherViewModel {
    var cityName: String?
    var weekday: String?
    var temperature: String?
    var weatherCondition: String?
    var timeOfDay: String?
    var icon: UIImage?
    private let defaultString = "-"
    
    init(model: ForecastWeather) {
        self.weekday = self.getDayOfWeek(fromDate: model.date , type: "day")
        self.weatherCondition = model.weatherCondition
        
        let degree = "°"
        self.temperature = String(model.temperature) + degree
        
        self.timeOfDay = self.getDayOfWeek(fromDate: model.date , type: "time")
        
        let weatherIcon = WeatherIcon(iconString: model.icon)
        self.icon = weatherIcon.image
        self.cityName = model.cityName
    }
    
     func getDayOfWeek( fromDate: Double, type : String) -> String {
        let date = Date(timeIntervalSince1970: fromDate)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
//      dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        if ( type == "day"){
            dateFormatter.dateFormat = "EEEE" //Convert to day
        }else{
            dateFormatter.dateFormat = "h:mm a" //Convert to time
        }
        let resultString = dateFormatter.string(from: date)
        return resultString
    }
    

}
