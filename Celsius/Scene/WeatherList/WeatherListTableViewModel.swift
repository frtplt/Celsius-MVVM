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
    
    func numberOfSection() -> Int { 1 }
    
    func numberOfRows(_ section: Int) -> Int {
        return weatherViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherPresentation {
        return weatherViewModels[index]
    }
}
