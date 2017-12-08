

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class WeatherViewController: UIViewController, CLLocationManagerDelegate, changeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "8862507877b9710fb9883e116b5f6dfe"
    
    //Outlets
    @IBOutlet weak var labellll: UILabel!
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here. 1st
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization() //- go through info plist for this and also check http configuration
        locationManager.startUpdatingLocation()
        
        
    }
    
    
    
    //MARK: - Networking  3rd
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url : String , parameters: [String : String]){
        Alamofire.request(url, method:.get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess{
                print("Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
            }
            else{
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issue"
            }
        }
        
    }

    
    
    
    
    
    //MARK: - JSON Parsing  under switch 4th
    /***************************************************************/
   
    @IBAction func switchUsed(_ sender: UISwitch) {
        if sender.isOn{
        
            cityLabel.text = weatherDataModel.city
            temperatureLabel.text = String(weatherDataModel.temperature + ((9/5) + 32))
            weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
            labellll.text = "℉"
            
        }
        else{
            updateUIWithWeatherData()
        }
    }
    
    //Write the updateWeatherData method here under switch:
   
    func updateWeatherData(json : JSON){
        if let tempResult = json["main"]["temp"].double {
        // ^ to change from json format to double as the value for example is 241.56
        weatherDataModel.temperature = Int(tempResult - 273.15) //to convert from Kelvin to Celsius
        weatherDataModel.city = json["name"].stringValue
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUIWithWeatherData()
           
    }
        else{
            cityLabel.text = "Weather Unavailable"
        }
    }

    
    
    
    //MARK: - UI Updates  5th
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    func updateUIWithWeatherData(){
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = String(weatherDataModel.temperature)
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        labellll.text = "℃"
    }
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods  2nd
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0{
            locationManager.startUpdatingLocation()
            locationManager.delegate = nil//to get the data from web server only once
            print("longittude = \(location.coordinate.longitude) and latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let param :[String : String] = ["lat" : latitude , "lon" : longitude , "appid" : APP_ID] // to give to website  because of api rule/agreement
            getWeatherData(url: WEATHER_URL, parameters: param)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    

    
    //MARK: - Change City Delegate methods  6th
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    func userTypedName(city: String) {
        let param2 : [String : String] = ["q" : city , "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: param2)
    }

    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName"{
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
    
    
    
    
}


