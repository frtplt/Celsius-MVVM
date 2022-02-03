//
//  WeatherListTableViewModel.swift
//  Celsius
//
//  Created by Firat on 27.01.2022.
//

import Foundation
import UIKit

protocol WeatherListViewModelDelegate: AnyObject {
    func reloadItems()
}

class WeatherListTableViewModel {
    
    private var weatherViewModels = [WeatherViewModel]()
    private var webService: WebServiceProtocol
    
    weak var delegate: WeatherListViewModelDelegate?
    var lastUnitSelection: Unit!
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }

     func addWeatherViewModel(_ viewModel: WeatherViewModel){
        weatherViewModels.append(viewModel)
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return weatherViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }

    private func toCelsius() {
        weatherViewModels = weatherViewModels.map { viewModel in
            let weatherModel = viewModel
            weatherModel.tempature = (weatherModel.tempature - 32) * 5/9
            return weatherModel
        }
    }
    
    private func toFahrenheit() {
        weatherViewModels = weatherViewModels.map { viewModel in
            let weatherModel = viewModel
            weatherModel.tempature = (weatherModel.tempature * 9/5) + 32
            return weatherModel
        }
    }
    
    func updateUnit(to unit: Unit) {
        switch unit {
        case .celsius:
            toCelsius()
        case .fahrenheit:
            toFahrenheit()
        }
    }
    
    func lastUnit() {
    let userDefaults = UserDefaults.standard
    if let value = userDefaults.value(forKey: "unit") as? String {
        self.lastUnitSelection = Unit(rawValue: value)!
    }
  }
}

class WeatherViewModel {
    
    let weather: WeatherResponse
    var tempature: Double
    
    init(weather: WeatherResponse) {
        self.weather = weather
        tempature = weather.main.temp
    }
    var city: String {
        return weather.name
    }
    var weatherid: Int {
        return weather.weather[0].id
    }
    var conditionName: String {
        switch weatherid {
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
            return "cloud"
        }
    }
}

























/*
struct WeatherDataListViewModel {
    let weathers: [WeatherData]
}
extension WeatherDataListViewModel {
    func numberOfSection() -> Int {
        return 1
    }
    func numberRowsInSection(_ section: Int) -> Int {
        return self.weathers.count
    }
    func weatherAtIndex(_ index: Int) -> WeatherDataViewModel {
        let weather = self.weathers[index]
        return WeatherDataViewModel(weather)
    }
}

struct WeatherDataViewModel {
        
    private let weather: WeatherData
        
}
extension WeatherDataViewModel {
    
    
    init(_ weather:WeatherData){
        
        self.weather = weather

    }
}
extension WeatherDataViewModel {
    
    var name: String {
        return self.weather.name
    }
    var temp: Double {
        return self.weather.main.temp
    }
    var id: Int {
        return self.weather.weather[0].id
    }
    
    
}
    
*/
    

