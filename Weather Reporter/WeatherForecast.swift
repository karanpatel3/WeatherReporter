//
//  WeatherForecast.swift
//  Weather Reporter
//
//  Created by Karan Patel on 4/20/20.
//  Copyright © 2020 Karan Patel. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherForecastDelegate {
    func didUpdateWeather(_ weatherForecast: WeatherForecast, weathers: [WeatherFModel])
    func didFailWithError(error: Error)
}


struct WeatherForecast {
//let weatherURL = "https://api.openweathermap.org/data/2.5/forecast/daily?appid=84dde353cf2757e657ef9075598771c2&units=imperial"
let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?appid=84dde353cf2757e657ef9075598771c2&units=imperial"

var delegate: WeatherForecastDelegate?

func fetchWeather(addr: String!)
{
    geocoder.geocodeAddressString(addr) { placemarks, error in
        let placemark = placemarks?.first
        if let location = placemark?.location {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            //print("\(lat), \(lon)")
            self.fetchWeather(latitude: lat, longitude: lon)
        }
    }
}

func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
    print(urlString)
    performRequest(with: urlString)
}

func performRequest(with urlString: String) {
    if let url = URL(string: urlString) {
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            if let safeData = data {
                if let weathers = self.parseJSON(safeData) {
                    self.delegate?.didUpdateWeather(self, weathers: weathers)
                }
            }
        }
        
        task.resume()
        
    }
}

func parseJSON(_ weatherFData: Data) -> [WeatherFModel]?{
    let decoder = JSONDecoder()
    do {
        //let decodedData = try decoder.decode(WeatherFData.self, from: weatherFData)
//        let name = decodedData.city.name
//        let lat = decodedData.city.
//        print(name)
//        var weatherFModels = [WeatherFModel]()
//        for day in decodedData.list{
//            let tem = day.temp.day
//            let dt = day.dt
//            //let feels = day.feels_like
//            let press = day.pressure
//            let humi = day.humidity
//            let id = (day.weather[0].id)
//            let desc = day.weather[0].descriptio
//            let weather = WeatherModel(conditionId: id, temperature: tem, description: desc)
//            weatherFModels.append(WeatherFModel(dateTime: dt, cityName: name, pressure: press, humidity: humi, weather: weather))
//        }
        let decodedData = try decoder.decode(OneCallData.self, from: weatherFData)
        let lat = decodedData.lat
        let lon = decodedData.lon
        var weatherFModels = [WeatherFModel]()
        for day in decodedData.daily{
            let tem = day.temp.day
            let dt = day.dt
            let press = day.pressure
            let humi = day.humidity
            let id = day.weather[0].id
            let desc = day.weather[0].description
            let weather = WeatherModel(conditionId: id, latitute: lat, longitute: lon, temperature: tem, description: desc)
            weatherFModels.append(WeatherFModel(dateTime: dt, pressure: press, humidity: humi, weather: weather))
        }
        return weatherFModels
        
    } catch {
        delegate?.didFailWithError(error: error)
        return nil
    }
    
}



}


