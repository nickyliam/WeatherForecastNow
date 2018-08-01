//
//  CurrentWeatherVIewController.swift
//  WeatherNow
//
//  Created by macmini on 29/07/2018.
//  Copyright © 2018 Kaho. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


 var currentWeatherViewModel : CurrentWeatherViewModel!

class CurrrentWeatherViewController : UIViewController, CLLocationManagerDelegate
{
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var currentWeatherLocation: UILabel!
    @IBOutlet weak var currentWeather: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet var currentWeatherPageView: UIView!
    var isLocationUpdated = false
    
  
   
    /*============================== SHARING METHODS ========================================*/
    @IBAction func shareButton(_ sender: Any) {
        if isLocationUpdated{
            let sharedText = "Today temperature in \(currentWeatherViewModel.cityName!) is \(currentWeatherViewModel.temperature!)"
            let activityController = UIActivityViewController(activityItems: [sharedText], applicationActivities: nil)
        
            activityController.completionWithItemsHandler = { (nil, completed, _, error) in
                if completed {
                    let alert = UIAlertController(title: "Weather Shared! ", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }else {
                    let alert = UIAlertController(title: "Canceled! ", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        
            present(activityController, animated: true){
            }
        }
    }
    
    /*============================== LOCATION METHODS ========================================*/
    var locationManager = CLLocationManager()
    
    
    func askForLocationPermissions() {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings to use this app", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            case .authorizedAlways, .authorizedWhenInUse:
                dismiss(animated: true)
            }
        } else {
            // Location services are not enabled
            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings to use this app", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func getCoordinate()->(lat: Double, lon : Double){
        if let  latitude = locationManager.location?.coordinate.latitude {
            if let longitude = locationManager.location?.coordinate.longitude{
                let roundedLat = (round(100*latitude)/100)
                let roundedLon = (round(10*longitude)/10)
                return (roundedLat,roundedLon)
            }
        }
        return ( 8888, 8888 )
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isLocationUpdated == false {
            getCurrentWeather()
            isLocationUpdated = true
            locationManager.stopUpdatingLocation()
        }
    }
    
    /*============================== CURRENT WEATHER METHODS ========================================*/
    func getCurrentWeather() {
        let latitude = getCoordinate().lat
        let longtitude = getCoordinate().lon
        
        let currentWeatherService = WeatherService(APIKey:"c0513dd4b853defbfe30b6784e925726")
        
        currentWeatherService.getCurrentWeather(latitude: (latitude), longtitude: (longtitude)) {currentWeather in
            DispatchQueue.main.async {
                if let currentWeather = currentWeather {
                    currentWeatherViewModel = CurrentWeatherViewModel(model: currentWeather)
                    // update UI
                    self.displayWeather(using: currentWeatherViewModel)
                    // save weather
                    let firebase = FireBase()
                    firebase.saveUserLocation(model: currentWeatherViewModel)
                }
            }
        }
    }
    
    func displayWeather(using viewModel: CurrentWeatherViewModel) {
        self.currentWeatherLocation.text = viewModel.cityName
        self.currentTemperature.text = viewModel.temperature
        self.currentWeather.text = viewModel.weatherCondition
        self.humidity.text = viewModel.humidity
        self.precipitationLabel.text = viewModel.precipitationProbability
        self.pressureLabel.text = viewModel.pressure
        self.windLabel.text = viewModel.windSpeed
        self.windDirectionLabel.text = viewModel.windDirection
        self.weatherIcon.image = viewModel.icon
        weatherIcon.pulsate()
    }
    

    override func viewDidLoad() {
        navigationItem.title = "Today"
        
        self.locationManager.requestWhenInUseAuthorization()
        askForLocationPermissions()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }

}

extension UIImageView {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.1
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
