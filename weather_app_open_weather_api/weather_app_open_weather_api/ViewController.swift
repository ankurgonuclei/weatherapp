//
//  ViewController.swift
//  weather_app_open_weather_api
//
//  Created by Ankur Pandey on 03/07/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("The weather is...\n")
        // Do any additional setup after loading the view.
        NetworkController.fetchWeather { weather in
        print("The weather is...\n")
        print(weather)
    }
    }


}

