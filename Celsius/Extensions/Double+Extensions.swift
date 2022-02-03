//
//  Double+Extensions.swift
//  Celsius
//
//  Created by Firat on 31.01.2022.
//

import Foundation

extension Double {
    
    func formatAsDegree() -> String {
        return String(format: "%.0f", self)
    }
}
