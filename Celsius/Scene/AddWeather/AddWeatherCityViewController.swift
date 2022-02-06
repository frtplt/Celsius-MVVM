//
//  AddWeatherCityViewController.swift
//  Celsius
//
//  Created by Firat on 26.01.2022.
//

import Foundation
import UIKit

protocol AddWeatherDelegate {
    func searchWeather(withCity city: String)
}

final class AddWeatherCityViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    var delegate: AddWeatherDelegate?
    
    @IBAction func saveCityButtonPressed() {
        if cityNameTextField.text != "" {
            if let city = cityNameTextField.text {
                delegate?.searchWeather(withCity: city)
                dismiss(animated: true)
            }
        }
        else {
            showError()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Wrong City Name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
