//
//  WeatherLoader.swift
//  WeatherApp
//
//  Created by Владимир Макаров on 30.05.2022.
//

import Foundation
import CoreLocation

final class WeatherLoader: NSObject, ObservableObject {
    
    @Published var location: CLLocation? = nil
    @Published var mainWeather = MainWeatherData()
    @Published var weekDays = WeekDays()
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func loadMainWeatherData() {
        let queue = DispatchQueue.global(qos: .utility)
        guard let latitude = location?.coordinate.latitude, let lontitude = location?.coordinate.longitude else { return }
        queue.async {
            let url = "https://api.openweathermap.org/data/2.5/onecall?"
            let params = [
                "lat": "\(latitude)",
                "lon": "\(lontitude)",
                "appid": "e9cf5ce835334125ff3c727398f2b2d4",
                "exclude": "minutely,hourly,alerts",
                "units": "metric"
            ]
            let jsonDecoder = JSONDecoder()
            
            var urlWithParams = URLComponents(string: url)
            urlWithParams?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
            
            let task = URLSession.shared.dataTask(with: (urlWithParams?.url)!) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        let geocoder = CLGeocoder()
                        geocoder.reverseGeocodeLocation(self.location!) { placemark, error in
                            if let placemark = placemark {
                                if let cityName = placemark[0].locality {
                                    self.mainWeather.cityName = cityName
                                }
                            }
                        }
                        self.mainWeather = try! jsonDecoder.decode(MainWeatherData.self, from: data)
                        self.weekDays = try! jsonDecoder.decode(WeekDays.self, from: data)
                    }
                }
            }
            task.resume()
        }
    }
    
    static func prepareTimes(for timeIntervalInUTC: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = Date(timeIntervalSince1970: timeIntervalInUTC)
        
        return dateFormatter.string(from: date)
    }
}

extension WeatherLoader: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.location = location
            self.loadMainWeatherData()
            self.locationManager.stopUpdatingLocation()
        }
    }
}
