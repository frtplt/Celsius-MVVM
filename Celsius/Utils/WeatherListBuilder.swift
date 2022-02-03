//
//  WeatherListBuilder.swift
//  Celsius
//
//  Created by Firat on 3.02.2022.
//

import Foundation
import UIKit

final class WeatherListBuilder {
    static func make() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let navigationViewController = storyboard.instantiateInitialViewController() as? UINavigationController,
            let viewController = navigationViewController.topViewController as? WeatherListTableViewController else {
            fatalError("WeatherListTableViewController not found")
        }
        
        let webService = WebService()
        viewController.weatherListViewModel = WeatherListTableViewModel(webService: webService)
        return navigationViewController
    }
}
