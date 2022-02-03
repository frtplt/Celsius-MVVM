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
    
    func configure(_ viewModel:WeatherViewModel) {
        self.cityNameLabel.text = viewModel.city
        self.tempatureLabel.text = "\(viewModel.tempature.formatAsDegree())°"
        self.conditionImage.image = UIImage(systemName: viewModel.conditionName)?.withTintColor(.black, renderingMode: .alwaysOriginal)
    }
    
    
    
    
}
