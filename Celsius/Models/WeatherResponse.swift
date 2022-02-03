//
//  Weather.swift
//  Celsius
//
//  Created by Firat on 27.01.2022.
//

import Foundation
import UIKit

struct WeatherResponse: Codable {
    let name: String
    let main: Weather
    let weather: [WeatherId]
}

struct Weather: Codable {
    let temp: Double
    let humidity: Double
    
}

struct WeatherId: Codable {
    let id: Int
}
