//  Weather7Data.swift
//  Weather Reporter
//
//  Created by Lin on 4/23/20.
//  Copyright © 2020 Karan Patel. All rights reserved.
//

import Foundation

struct WeatherFData: Codable {
    let city: City
    let list: [DayData]
}

struct City: Codable {
    let id: Int
    let name: String
}

struct DayData: Codable {
    let dt: Int
    let temp: TempData
    let feels_like: FeelLike
    let pressure: Int
    let humidity: Int
    let weather: [Weather]
}

struct TempData: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct FeelLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}
