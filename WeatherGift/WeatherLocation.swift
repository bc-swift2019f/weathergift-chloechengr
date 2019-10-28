//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Chloe Cheng on 10/28/19.
//  Copyright © 2019 Chloe Cheng. All rights reserved.
//

import Foundation

class WeatherLocation: Codable {
    var name: String
    var coordinates: String
    
    init(name: String, coordinates: String) {
        self.name = name
        self.coordinates = coordinates
    }
}
