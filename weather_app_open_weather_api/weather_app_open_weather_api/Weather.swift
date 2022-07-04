//
//  Weather.swift
//  weather_app_open_weather_api
//
//  Created by Ankur Pandey on 03/07/22.
//

import Foundation

struct Weather: Decodable {
    var main: Main
    
    struct Main: Decodable {
        var temp: Double
        var feelsLike: Double
        var tempMin: Double
        var tempMax: Double
        var pressure: Double
        var humidity: Double
        
        enum CodingKeys: String, CodingKey {
            case temp
            case pressure
            case humidity
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
}
