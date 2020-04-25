//
//  SecondViewController.swift
//  Weather Reporter
//
//  Created by Karan Patel on 4/18/20.
//  Copyright © 2020 Karan Patel. All rights reserved.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    
    @IBOutlet weak var searchTextField: UITextField!

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var table: UITableView!
    
    var models = [WeatherFModel]()
    
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
        
        table.delegate = self
        table.dataSource = self
        
        self.table.reloadData()
        
    }
    
    func getDateTime(timestamp: Int) -> String {
        var strDate = "undefined"
            

        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM/dd" //Specify your format that you want
        strDate = dateFormatter.string(from: date)
            
        return strDate
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.table.backgroundColor = .clear

        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
        let w = models[indexPath.row]
        
        cell.date.text = self.getDateTime(timestamp: w.dateTime)
        cell.icon.image = UIImage(named: w.weather.conditionName)
        cell.desc.text = w.weather.description.capitalized
        cell.temp.text = "\(w.weather.temperatureString)°F"
        
        cell.backgroundColor = .clear
        return cell
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
        self.models = weathers
//        let images = [self.image1, self.image2, self.image3, self.image4, self.image5]
//        let descriptions = [self.desc1, self.desc2, self.desc3, self.desc4, self.desc5]
//        let temps = [self.temp1, self.temp2, self.temp3, self.temp4, self.temp5]
//        let dts = [self.dt1, self.dt2, self.dt3, self.dt4, self.dt5]
        //print(weathers)
        DispatchQueue.main.async {
            self.table.reloadData()
            self.cityName.text = weathers[0].cityName
//            self.cityName.text = weathers[0].cityName
//            for (i, imageView) in images.enumerated(){
//                //imageView?.image = UIImage(systemName: weathers[i].weather.conditionName)
//                dts[i]?.text = self.getDateTime(timestamp: weathers[i].dateTime)
//                imageView?.image = UIImage(named: weathers[i].weather.conditionName)
//                descriptions[i]?.text = weathers[i].weather.description.capitalized
//                temps[i]?.text = weathers[i].weather.temperatureString
//            }
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
