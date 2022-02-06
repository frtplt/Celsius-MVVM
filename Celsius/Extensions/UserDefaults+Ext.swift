//
//  UserDefaults.swift
//  Celsius
//
//  Created by Gökhan Namal on 5.02.2022.
//

import Foundation

extension UserDefaults {
    var weatherUnit: Unit {
        let rawValue = string(forKey: "unit") ?? "imperial"
        return Unit(rawValue: rawValue) ?? .celsius
    }
}
