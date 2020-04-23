//
//  SecondViewController.swift
//  Weather Reporter
//
//  Created by Karan Patel on 4/18/20.
//  Copyright © 2020 Karan Patel. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
@IBOutlet weak var searchTextField: UITextField!
    

    @IBOutlet weak var cell1: ForecastTableViewCell!
    
    var weatherForecast = WeatherForecast()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
        print(weathers)
        DispatchQueue.main.async { // Correct

        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}
