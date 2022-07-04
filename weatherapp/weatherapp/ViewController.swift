//
//  ViewController.swift
//  weatherapp
//
//  Created by Ankur Pandey on 29/06/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  CLLocationManagerDelegate {
    /*/
     var temp: Double
     var feelsLike: Double
     var tempMin: Double
     var tempMax: Double
     var pressure: Double
     var humidity: Double*/
    
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var tempMinLabel: UILabel!
    @IBOutlet var tempMaxLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    var models = [WeatherResponse]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil{
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation(){
        guard let currentLocation = currentLocation else {
            return
        }
        
        let lon = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        print("\(lon) | \(lat)")
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=a25168da5eb0e24e796fb52861b8a366"
        
        print("url path: \(url)")
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            // Validation
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            // Convert data to models/some object
            var json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            }
            catch {
                print("error: \(error)")
            }
            
            guard let result = json else {
                return
            }
            
            print("result: \(result.main.feelsLike)")
            
            DispatchQueue.main.async {
                self.tempLabel.text = String(format: "%.2f", (result.main.temp).kelvinToCelsius) + "° C"
                self.placeLabel.text = result.name
                self.feelsLikeLabel.text = String(format: "%.2f", (result.main.feelsLike).kelvinToCelsius) + "° C"
                self.tempMinLabel.text = String(format: "%.2f", (result.main.tempMin).kelvinToCelsius) + "° C"
                self.tempMaxLabel.text = String(format: "%.2f", (result.main.tempMax).kelvinToCelsius) + "° C"
                self.pressureLabel.text = String(format: "%.2f", (result.main.pressure))
                self.humidityLabel.text = String(format: "%.2f", (result.main.humidity))
            }
            
        }).resume()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

struct WeatherResponse: Decodable {
    var main: Main
    var name: String
    
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

