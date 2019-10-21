//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Chloe Cheng on 10/20/19.
//  Copyright © 2019 Chloe Cheng. All rights reserved.
//

import Foundation
import Alamofire

class WeatherLocation {
    var name = ""
    var coordinates = ""
    
    func getWeather() {
        let weatherURL = urlBase + urlAPIKey + coordinates
        print(weatherURL)
        
        Alamofire.request(weatherURL).responseJSON { response in
            print(response)
        }
    }
}
