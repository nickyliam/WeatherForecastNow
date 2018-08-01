//
//  ForecastTableViewController.swift
//  WeatherNow
//
//  Created by macmini on 26/07/2018.
//  Copyright © 2018 Kaho. All rights reserved.
//

import Foundation
import UIKit

class ForecastTableVIewController :  UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableVIew: UITableView!
    var forecastWeatherViewModels: [ForecastWeatherViewModel] = []
    var array1 = [String : Any]()

    /*============================== FORECAST METHODS ========================================*/

    func getforecastWeather(latitude: Double, longtitude: Double) {
        let forecastService = WeatherService(APIKey:"c0513dd4b853defbfe30b6784e925726")
        forecastService.getForecast(latitude: latitude, longtitude: longtitude) {forecastWeather in
          DispatchQueue.main.async {
                if let forecastsWeather = forecastWeather {
                    // reset self.forecastWeatherViewModels to avoid repeat items
                    if forecastsWeather.count > 0 {
                        self.forecastWeatherViewModels = []
                    }
                    for forecastsWeather in forecastsWeather {
                        let forecastWeatherVM = ForecastWeatherViewModel(model: forecastsWeather)
                        self.forecastWeatherViewModels.append(forecastWeatherVM)
                    }
                }
            self.tableVIew.reloadData()
            }
        }
    }
    
    /*============================== TABLE VIEW METHODS ========================================*/
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return self.forecastWeatherViewModels.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let forecastWeatherViewMode = self.forecastWeatherViewModels[indexPath.row]

        // Dequeue Reusable Cell
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath) as! TableViewCell

        // Configure Cell
        cell.weatherIcon.image = forecastWeatherViewMode.icon
        cell.timeLabel.text = forecastWeatherViewMode.timeOfDay
        cell.weatherLabel.text = forecastWeatherViewMode.weatherCondition
        cell.temperatureLabel.text = forecastWeatherViewMode.temperature
        cell.dayLabel.text = forecastWeatherViewMode.weekday

        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentWeather = CurrrentWeatherViewController()
        currentWeather.askForLocationPermissions()
        
        // If coordinate exists
        if currentWeather.getCoordinate().lat != 8888  {
            if currentWeather.getCoordinate().lon != 8888{
                getforecastWeather(latitude: currentWeather.getCoordinate().lat, longtitude: currentWeather.getCoordinate().lon)
                if let currentWeatherVM = currentWeatherViewModel{
                    navigationItem.title = currentWeatherVM.cityName
                }
            }
        }
    }


    
    
}
