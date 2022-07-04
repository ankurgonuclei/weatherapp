//
//  DoubleTempFConversion.swift
//  weatherapp
//
//  Created by Ankur Pandey on 04/07/22.
//

import Foundation
extension Double {
    var kelvinToFahrenhit: Double {
        return (9.0 / 5) * (self - 273) + 32
    }
    
    var kelvinToCelsius: Double {
        return (self - 273)
    }
}
