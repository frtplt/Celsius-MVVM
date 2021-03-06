//
//  String-Extensions.swift
//  Celsius
//
//  Created by Firat on 27.01.2022.
//

import Foundation

extension String {
    var escaped: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}
