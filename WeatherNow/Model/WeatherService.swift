//
//  ForecaseService.swift
//  WeatherNow
//
//  Created by macmini on 26/07/2018.
//  Copyright © 2018 Kaho. All rights reserved.
//

import Foundation

class WeatherService
{
    let APIKEY : String
    let forecastBaseURL : URL
    let currentWeatherURL : URL
    
    
    init(APIKey : String){
        self.APIKEY = APIKey
        forecastBaseURL = URL(string :"https://api.openweathermap.org/data/2.5/forecast?APPID=\(APIKEY)")!
        currentWeatherURL = URL(string :"https://api.openweathermap.org/data/2.5/weather?APPID=\(APIKEY)")!
    }
    
    func getForecast(latitude:Double, longtitude:Double, completion: @escaping ([ForecastWeather]?) -> Void)
    {

        if let forecastURL = URL(string: "\(forecastBaseURL)&lat=\(latitude)&lon=\(longtitude)"){
            let networkProcessor = NetworkProcessor(url:forecastURL)
            networkProcessor.downloadJSONFromURL { (response) in
                if let forecastWeatherDictionary = response as NSDictionary?{
                    
                    var forecasts: [ForecastWeather] = []
                    
                    if let forecast2 = forecastWeatherDictionary["list"] as? [[String : Any]] {
                        for obj in forecast2 {
                            let forecast = ForecastWeather(weatherDictionary: obj)
                            forecasts.append(forecast!)
                        }
                         completion(forecasts)
                    }
                }else{
                    completion(nil)
                }
            }
        }
    }
    
    func getCurrentWeather(latitude:Double, longtitude:Double, completion: @escaping (CurrentWeather?)-> Void)
    {
        if let currentWeatherURL = URL(string: "\(currentWeatherURL)&lat=\(latitude)&lon=\(longtitude)"){
            let networkProcessor = NetworkProcessor(url:currentWeatherURL)
            networkProcessor.downloadJSONFromURL { (response) in
                if let currentWeatherDic = response {
                    let currentWeather = CurrentWeather(json: currentWeatherDic)
                    completion(currentWeather)
                }else{
                    completion(nil)
                }
            }
        }
    }

}

