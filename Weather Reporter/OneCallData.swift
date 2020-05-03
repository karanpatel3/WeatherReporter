//
//  OneCallData.swift
//  Weather Reporter
//
//  Created by Lin on 4/30/20.
//  Copyright © 2020 Karan Patel. All rights reserved.
//

import Foundation

struct OneCallData: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let current: CurrentWeather
    let hourly: [Hourly]
    let daily: [Daily]
}

struct CurrentWeather: Codable  {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let weather: [TheWeather]
}

struct Hourly: Codable  {
    let dt: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: Double
    let wind_deg: Double
    let weather: [TheWeather]
}

struct Daily: Codable  {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: DailyTemp
    let feels_like: DailyFeelsLike
    let pressure: Int
    let humidity: Int
    let wind_speed: Double
    let wind_deg: Double
    let weather: [TheWeather]
    let clouds: Int
    let uvi: Double
}

struct DailyTemp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct DailyFeelsLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct TheWeather: Codable {
    let id: Int
    let main: String
    let description: String
}

