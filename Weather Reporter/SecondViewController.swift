//
//  SecondViewController.swift
//  Weather Reporter
//
//  Created by Karan Patel on 4/18/20.
//  Copyright © 2020 Karan Patel. All rights reserved.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController {

    
    @IBOutlet weak var searchTextField: UITextField!

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    @IBOutlet weak var desc1: UILabel!
    @IBOutlet weak var desc2: UILabel!
    @IBOutlet weak var desc3: UILabel!
    @IBOutlet weak var desc4: UILabel!
    @IBOutlet weak var desc5: UILabel!
    
    @IBOutlet weak var temp1: UILabel!
    @IBOutlet weak var temp2: UILabel!
    @IBOutlet weak var temp3: UILabel!
    @IBOutlet weak var temp4: UILabel!
    @IBOutlet weak var temp5: UILabel!
    
    let locationManager = CLLocationManager()
    
    var weatherForecast = WeatherForecast()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherForecast.delegate = self
        searchTextField.delegate = self
    }
    
    
}
    
    extension SecondViewController: UITextFieldDelegate {

        @IBAction func searchedPressed(_ sender: UIButton) {
             searchTextField.endEditing(true)
             print(searchTextField.text!)
         }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchTextField.endEditing(true)
            print(searchTextField.text!)
            return true
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != "" {
                return true
            }
            else {
                textField.placeholder = "Type something"
                return false
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            if let city = searchTextField.text {
                weatherForecast.fetchWeather(cityName: city)
                //print(city)
            }
            
            searchTextField.text = ""
        }
    }


extension SecondViewController: WeatherForecastDelegate {
    func didUpdateWeather(_ weatherForecast: WeatherForecast, weathers: [WeatherFModel]) {
        let images = [self.image1, self.image2, self.image3, self.image4, self.image5]
        let descriptions = [self.desc1, self.desc2, self.desc3, self.desc4, self.desc5]
        let temps = [self.temp1, self.temp2, self.temp3, self.temp4, self.temp5]
        //print(weathers)
        DispatchQueue.main.async {
            self.cityName.text = weathers[0].cityName
            for (i, imageView) in images.enumerated(){
                //imageView?.image = UIImage(systemName: weathers[i].weather.conditionName)
                imageView?.image = UIImage(named: weathers[i].weather.conditionName)
                descriptions[i]?.text = weathers[i].weather.description.capitalized
                temps[i]?.text = weathers[i].weather.temperatureString
            }
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}

extension SecondViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherForecast.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
