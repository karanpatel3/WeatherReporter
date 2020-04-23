//
//  WeatherData.swift
//  Weather Reporter
//
//  Created by Karan Patel on 4/18/20.
//  Copyright © 2020 Karan Patel. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String?
    let main: Main?
    let weather: [Weather]?
    let list: [List]?
}

struct Main: Codable {
    let temp: Double?
    let temp_min: Double?
    let temp_max: Double?
}

struct Weather: Codable {
    let description: String?
    let id: Int?
}

struct List: Codable {
    let description: String?
    let main: Main?
    let weather: [Weather]?
    let id: Int?
}
