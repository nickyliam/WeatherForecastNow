//
//  WeatherIcons.swift
//  WeatherNow
//
//  Created by macmini on 28/07/2018.
//  Copyright © 2018 Kaho. All rights reserved.
//

import Foundation
import UIKit

enum WeatherIcon {
    case clearSky
    case fewClouds
    case scatteredClouds
    case brokenClouds
    case showerRain
    case rain
    case thunderstorm
    case snow
    case mist
    case clearSkyNight
    case fewCloudsNight
    case scatteredCloudsNight
    case brokenCloudsNight
    case showerRainNight
    case rainNight
    case thunderstormNight
    case snowNight
    case mistNight
    case `default`
    
    init(iconString: String) {
        switch iconString {
        case "01d": self = .clearSky
        case "01n": self = .clearSkyNight
        case "02d": self = .fewClouds
        case "02n": self = .fewCloudsNight
        case "03d": self = .scatteredClouds
        case "03n": self = .scatteredCloudsNight
        case "04d": self = .brokenClouds
        case "04n": self = .brokenCloudsNight
        case "09d": self = .showerRain
        case "09n": self = .showerRainNight
        case "10d": self = .rain
        case "10n": self = .rainNight
        case "11d": self = .thunderstorm
        case "11n": self = .thunderstormNight
        case "13d": self = .snow
        case "13n": self = .snowNight
        case "50d": self = .mist
        case "50n": self = .mistNight
        default: self = .default
        }
    }
}

extension WeatherIcon {
    var image: UIImage {
        switch self {
        case .clearSky: return #imageLiteral(resourceName: "Clear Sky")
        case .clearSkyNight: return #imageLiteral(resourceName: "Clear Sky-1")
        case .fewClouds: return #imageLiteral(resourceName: "Few Clouds")
        case .fewCloudsNight: return #imageLiteral(resourceName: "Few Clouds-1")
        case .scatteredClouds: return #imageLiteral(resourceName: "Scattered Clouds")
        case .scatteredCloudsNight: return #imageLiteral(resourceName: "Scattered Clouds-1")
        case .brokenClouds: return #imageLiteral(resourceName: "Broken Clouds")
        case .brokenCloudsNight: return #imageLiteral(resourceName: "Broken Clouds")
        case .showerRain: return #imageLiteral(resourceName: "Shower Rain")
        case .showerRainNight: return #imageLiteral(resourceName: "Shower Rain-1")
        case .rain: return #imageLiteral(resourceName: "Rain")
        case .rainNight: return #imageLiteral(resourceName: "Rain")
        case .thunderstorm: return #imageLiteral(resourceName: "Thunderstorm")
        case .thunderstormNight: return #imageLiteral(resourceName: "Thunderstorm")
        case .snow: return #imageLiteral(resourceName: "Snow")
        case .snowNight: return #imageLiteral(resourceName: "Snow")
        case .mist: return #imageLiteral(resourceName: "Mist")
        case .mistNight: return #imageLiteral(resourceName: "Mist")
        case .default: return #imageLiteral(resourceName: "Clear Sky")
        }
    }
    
}
