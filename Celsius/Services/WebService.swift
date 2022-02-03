//
//  WebService.swift
//  Celsius
//
//  Created by Firat on 27.01.2022.
//

import Foundation

protocol WebServiceProtocol {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> Void)
}

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

    final class WebService: WebServiceProtocol {
    
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> Void){
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            }
            else{
                completion(nil)
            }
        }.resume()
    }
    
    func addWeather(for city: String, completion: @escaping (WeatherViewModel) -> Void){
        
        let weatherUrl = Constants.Urls.urlForWeatherByCity(city: city)
        
        let weatherResource = Resource<WeatherResponse>(url: weatherUrl) { data in
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse
        }
        WebService().load(resource: weatherResource) { (result) in
            if let weatherResource = result {
                let viewModel = WeatherViewModel(weather: weatherResource)
                completion(viewModel)
            }
        }
    }
}






















/*class WebService {
    
    func getWeather(url: URL, completion: @escaping ([WeatherData]?) -> ()){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            }else if let data = data {
                
                let weatherList = try? JSONDecoder().decode(WeatherList.self, from: data)
                
                if let weatherList = weatherList{
                    completion(weatherList.weatherList)
                    
                }
        }

    }.resume()
    
}
}*/

