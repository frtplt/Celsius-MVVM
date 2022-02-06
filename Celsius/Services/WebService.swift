//
//  WebService.swift
//  Celsius
//
//  Created by Firat on 27.01.2022.
//

import Foundation

protocol WebServiceProtocol {
    func addWeather(forCity city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

enum WebServiceError: Swift.Error {
    case decoding(Swift.Error)
    case networking(Swift.Error?)
}

final class WebService: WebServiceProtocol {
    func addWeather(forCity city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        guard let query = city.escaped, let weatherUrl = Endpoints.search(query: query).url else {
            return
        }
    
        load(url: weatherUrl, responseType: WeatherResponse.self, completion: completion)
    }
}

extension WebService {
    private func load<ResponseType: Codable>(url: URL, responseType: ResponseType.Type, completion: @escaping (Result<ResponseType, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(WebServiceError.networking(error)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(responseType.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(WebServiceError.decoding(error)))
            }
        }.resume()
    }
}
