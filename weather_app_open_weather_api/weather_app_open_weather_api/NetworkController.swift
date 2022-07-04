//
//  NetworkController.swift
//  weather_app_open_weather_api
//
//  Created by Ankur Pandey on 03/07/22.
//

import Foundation

struct NetworkController {
    private static var baseUrl = "api.openweathermap.org"
    private static let apiKey = "a25168da5eb0e24e796fb52861b8a366"
    
    enum EndPoint {
        case cityId(path: String = "data/2.5/weather", id: Int)
        
        var url: URL? {
            var components = URLComponents()
            
            components.scheme = "https"
            components.host = baseUrl
            components.path = path
            components.queryItems = queryItems
            
            return components.url
        }
        
        private var path: String {
            switch self {
            case .cityId(let path, _):
                return path
            }
        }
        
        private var queryItems: [URLQueryItem] {
            var queryItems = [URLQueryItem]()
            switch self {
            case .cityId(_, let id):
                queryItems.append(URLQueryItem(name: "id", value: String(id)))
            }
            
            queryItems.append(URLQueryItem(name: "appid", value: apiKey))
            
            return queryItems
        }
    }
    
    static func fetchWeather(for cityId: Int = 5128581, _ completion: @escaping ((Weather) -> Void)) {
        if let url = EndPoint.cityId(id: cityId).url {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Whoops, and error occured!", error)
                }
                
                if let data = data {
                    do {
                        let weather = try JSONDecoder().decode(Weather.self, from: data)
                        completion(weather)
                    } catch let error {
                        print("failed to decode object...", error)
                    }
                }
            }.resume()
        }
    }
}
