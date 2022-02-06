//
//  WeatherCell.swift
//  Celsius
//
//  Created by Firat on 26.01.2022.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempatureLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    
    func configure(_ weather: WeatherPresentation, unit: Unit) {
        self.cityNameLabel.text = weather.city
        self.tempatureLabel.text = "\(weather.getTemp(withUnit: unit).formatAsDegree())"
        if let conditionName = weather.conditionName {
            let image =  UIImage(systemName: conditionName)
            self.conditionImage.image = image?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }
    }
}
