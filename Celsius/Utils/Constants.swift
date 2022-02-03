//
//  Constants.swift
//  Celsius
//
//  Created by Firat on 27.01.2022.
//

import Foundation

struct Constants {
    
    struct Urls {
        
        static func urlForWeatherByCity(city: String) -> URL{
            
            // Get the default setting for tempature
            
            let userDefaults = UserDefaults.standard
            let unit = (userDefaults.value(forKey: "unit") as? String) ?? "imperial"
            
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=00cadbb9f45d0fe582ee1c70ff5e8863&units=\(unit)")!
            
        }
    }
}
