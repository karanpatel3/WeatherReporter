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
    func didUpdateWeather(_ weatherForecast: WeatherForecast, weather: WeatherFModel)
    func didFailWithError(error: Error)
}


struct WeatherForecast {
let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=84dde353cf2757e657ef9075598771c2&units=imperial"

var delegate: WeatherForecastDelegate?

func fetchWeather(cityName: String)
{
    let urlString = "\(weatherURL)&q=\(cityName)"
    print(urlString)
    performRequest(with: urlString)
}

func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
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
                if let weather = self.parseJSON(safeData) {
                    self.delegate?.didUpdateWeather(self, weather: weather)
                }
            }
        }
        
        task.resume()
        
    }
    
}

func parseJSON(_ weatherData: Data) -> WeatherFModel?{
    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
        let min = decodedData.list![0].main!.temp_min

        let max = decodedData.list![0].main!.temp_max


        let id = decodedData.list![0].weather![0].id!
        let weather = WeatherFModel(conditionId: id, min: min!, max: max!)
        return weather
    } catch {
        delegate?.didFailWithError(error: error)
        return nil
    }
    
}



}


