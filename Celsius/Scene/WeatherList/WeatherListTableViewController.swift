//
//  WeatherListTableViewController.swift
//  Celsius
//
//  Created by Firat on 26.01.2022.
//

import Foundation
import UIKit

final class WeatherListTableViewController: UITableViewController {
    var weatherListViewModel: WeatherListTableViewModel? {
        didSet {
            weatherListViewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return weatherListViewModel?.numberOfSection() ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel?.numberOfRows(section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
            fatalError("WeatherCell not found")
        }
        
        guard let weatherListViewModel = weatherListViewModel else {
            return cell
        }
        
        cell.configure(weatherListViewModel.modelAt(indexPath.row), unit: weatherListViewModel.lastUnitSelection)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherCityViewController" {
            prepareSegueForAddWeatherCityViewController(segue: segue)
        }else if segue.identifier == "SettingsTableViewController" {
            prepareSegueForSettingsTableViewController(segue: segue)
        }
    }
    
    func prepareSegueForSettingsTableViewController(segue: UIStoryboardSegue){
        guard let navigation = segue.destination as? UINavigationController else {
            fatalError("Navigation Controller not found")
        }
        guard let settingsTableViewController = navigation.viewControllers.first as? SettingsTableViewController else {
            fatalError("SettingsTableViewController not found")
        }
        settingsTableViewController.delegate = self
        settingsTableViewController.settingsViewModel = SettingsViewModel()
    }
    
    func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue){
        guard let navigation = segue.destination as? UINavigationController else {
            fatalError("Navigation Controller not found")
        }
        guard let addWeatherCityViewController = navigation.viewControllers.first as? AddWeatherCityViewController else {
            fatalError("AddWeatherCityViewController not found")
        }
        addWeatherCityViewController.delegate = self
    }
}

extension WeatherListTableViewController: AddWeatherDelegate {
    func searchWeather(withCity city: String) {
        weatherListViewModel?.addWeather(withCity: city)
    }
}

extension WeatherListTableViewController: SettingsDelegate {
    func settingsDone(viewModel: SettingsViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension WeatherListTableViewController: WeatherListViewModelDelegate {
    func reloadItems() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

