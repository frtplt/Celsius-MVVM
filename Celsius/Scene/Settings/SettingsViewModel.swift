//
//  SettingsViewModel.swift
//  Celsius
//
//  Created by Firat on 31.01.2022.
//

import Foundation

enum Unit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    var displayName: String {
        get {
            switch(self) {
               case .celsius:
                  return "Celsius"
               case .fahrenheit:
                  return "Fahrenheit"
            }
        }
    }
}

struct SettingsViewModel {
    let units = Unit.allCases
    var selectedUnit: Unit {
        get {
            let userDefaults = UserDefaults.standard
            guard let value = userDefaults.string(forKey: "unit") else {
                return .celsius
            }
            return Unit(rawValue: value) ?? .celsius
        }
        set {
            let userDefault = UserDefaults.standard
            userDefault.set(newValue.rawValue, forKey: "unit")
        }
    }
}
