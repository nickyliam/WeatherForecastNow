//
//  CurrentWeather.swift
//  WeatherNow
//
//  Created by macmini on 26/07/2018.
//  Copyright © 2018 Kaho. All rights reserved.

import Foundation

struct ForecastWeather {
    var date: Double = Double.infinity
    var temperature = Int()
    var weatherCondition: String = ""
    var icon: String = ""
    var cityName :  String = ""
}

extension ForecastWeather {
    
    struct Key {
            static let date = "dt"
            static let tempKey = "temp"
            static let tempMain = "main"
            static let weatherKey = "weather"
            static let mainKey = "description"
            static let iconKey = "icon"
            static let  city = "city"
            static let  cityNameKey = "name"
    }
    
    init?(weatherDictionary: [String : Any]) {
        
        if let city = weatherDictionary[Key.city] as? [String : Any] {
            if let cityName = city[Key.cityNameKey] as? String{
                self.cityName = cityName
            }
        }
        
        if let dateValue = weatherDictionary[Key.date] as? Double {
            self.date = dateValue
        }

        if let main = weatherDictionary[Key.tempMain] as? [String : Any] {
            if let temperatureValue = main[Key.tempKey] as? Double {
                self.temperature = Int(temperatureValue - 273.15) // Converting K into celcius
            }
        }
        
        if let weather = weatherDictionary[Key.weatherKey] as? [[String:Any]] {
            if let weatherCondition = weather[0][Key.mainKey] as? String {
                self.weatherCondition = weatherCondition
//           print(weatherCondition)
            }
            
            if let iconValue = weather[0][Key.iconKey] as? String {
                self.icon = iconValue
            }
        }
    }
}


