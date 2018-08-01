//
//  CurrentWeatherViewModel.swift
//  WeatherNow
//
//  Created by macmini on 29/07/2018.
//  Copyright © 2018 Kaho. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeatherViewModel {
    var cityName: String?
    var temperature: String?
    var weatherCondition: String?
    var humidity: String?
    var precipitationProbability: String?
    var pressure: String?
    var windSpeed: String?
    var windDeg: Double?
    var windDirection: String?
    var icon: UIImage?
    let infinity = Double.infinity
    
    init(model: CurrentWeather) {
        self.cityName = model.cityName
        self.weatherCondition = model.weatherCondition
        
        let degreeUnit = "°C"
        self.temperature = String(model.temperature) + degreeUnit
        
        let humidityUnit = "%"
        self.humidity = String(model.humidity) + humidityUnit
        
        self.precipitationProbability = "N/A"
        if model.precipitationProbability < infinity{
            let precipUnit = "mm"
            self.precipitationProbability = String(model.precipitationProbability) + precipUnit
        }
        
        let pressureUnit = "hPa"
        self.pressure = String(model.pressure) + pressureUnit
        
        let speedUnit = "km/h"
        self.windSpeed = String(model.windSpeed) + speedUnit

        self.windDeg = model.windDeg

        
        self.windDirection = "N/A"

        if  model.windDeg != infinity {
            let windDirectionArray = ["N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW","N"]
            if model.windDeg > 360 {
                let remainderWindDegree = model.windDeg.truncatingRemainder(dividingBy: 360)
                let index = Int(round(remainderWindDegree/22.5) + 1)
                self.windDirection = windDirectionArray[index]
            }else{
                let index = Int(round(model.windDeg/22.5) + 1)
                self.windDirection = windDirectionArray[index]
            }
        }
        
        let weatherIcon = WeatherIcon(iconString: model.icon)
        self.icon = weatherIcon.image
        
    }
    
}
