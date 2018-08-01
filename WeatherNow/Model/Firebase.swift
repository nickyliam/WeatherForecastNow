//
//  Firebase.swift
//  WeatherNow
//
//  Created by macmini on 31/07/2018.
//  Copyright © 2018 Kaho. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase


class FireBase {
    
    func saveUserLocation(model : CurrentWeatherViewModel){
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        
        let userDataDic : [String:Any] = [
            "date":self.getTodayDate(),
            "location":model.cityName!,
            "temperature": model.temperature!,
            "humidity" : model.humidity!,
            "weather": model.weatherCondition!
        ]
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("UserUDID").child(uuid).setValue(userDataDic) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
    }
    
    func getTodayDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let currentDate = formatter.string(from: date)
        
        return currentDate
    }
    
    
}
