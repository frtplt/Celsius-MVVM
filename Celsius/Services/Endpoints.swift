//
//  Endpoints.swift
//  Celsius
//
//  Created by Firat on 27.01.2022.
//

import Foundation

enum Endpoints {
    private var baseURLString: String {
        "https://api.openweathermap.org"
    }
    
    case search(query: String)
    
    private var urlString: String {
        switch self {
        case .search(let query):
            return "\(baseURLString)/data/2.5/weather?q=\(query)&appid=00cadbb9f45d0fe582ee1c70ff5e8863&units=metric"
        }
    }
    
    var url: URL? {
        return URL(string: urlString)
    }
}
