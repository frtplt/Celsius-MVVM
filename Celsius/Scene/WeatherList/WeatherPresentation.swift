//
//  WeatherPresentation.swift
//  Celsius
//
//  Created by Firat on 6.02.2022.
//

import Foundation

struct WeatherPresentation {
    private let tempature: Double
    let city: String
    let conditionId: Int
    
    func getTemp(withUnit unit: Unit) -> Double {
        switch unit {
        case .celsius:
            return tempature
        case .fahrenheit:
            return (tempature * 9/5) + 32
        }
    }
    
    init(response: WeatherResponse) {
        self.tempature = response.main.temp
        self.city = response.name
        self.conditionId = response.weather.first?.id ?? -1
    }
    
    var conditionName: String? {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return nil
        }
    }
}
