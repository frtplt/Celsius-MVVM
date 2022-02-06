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
    private var weatherViewModels = [WeatherPresentation]()
    private var webService: WebServiceProtocol
    weak var delegate: WeatherListViewModelDelegate?
    var lastUnitSelection: Unit {
        UserDefaults.standard.weatherUnit
    }
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func addWeather(withCity city: String) {
        webService.addWeather(forCity: city) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let presentation = WeatherPresentation(response: response)
                self.weatherViewModels.append(presentation)
                self.delegate?.reloadItems()
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return weatherViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherPresentation {
        return weatherViewModels[index]
    }
}

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
    

