//
//  WeekDay.swift
//  WeatherApp
//
//  Created by Владимир Макаров on 30.05.2022.
//

import Foundation

struct WeekDays: Decodable {
    var daily: [WeekDay]
    
    init() {
        self.daily = [WeekDay(), WeekDay(), WeekDay(), WeekDay(), WeekDay(), WeekDay()]
    }
}

struct WeekDay: Decodable, Identifiable {
    var id = UUID()
    var date: String = "___"
    var temp: Double = 1
    var weather: [Weather] = [Weather(main: "Cloud", description: "So cloudy")]
    var imageName: String {
        switch weather[0].main {
        case "Thunderstorm":
            return "cloud.bolt.rain.fill"
        case "Drizzle":
            return "cloud.drizzle"
        case "Rain":
            return "cloud.rain"
        case "Snow":
            return "cloud.snow"
        case "Clear":
            return "sun.max"
        case "Clouds":
            return "cloud.sun.fill"
        default:
            return "sun.haze"
        }
    }
    
    private enum WeekDayKeys: String, CodingKey {
        case date = "dt"
        case temp
        case weather
    }
    
    private enum TempKeys: CodingKey {
        case day
    }
    
    init() {
        self.date = "TUE"
        self.temp = 1
        self.weather = [Weather(main: "Clouds", description: "Cloud with rain")]
    }
    
    init(from decoder: Decoder) throws {
        if let weekDaysContainer = try? decoder.container(keyedBy: WeekDayKeys.self) {
            if let tempContainer = try? weekDaysContainer.nestedContainer(keyedBy: TempKeys.self, forKey: .temp) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEE"
                let dateInTimeInterval = try weekDaysContainer.decode(TimeInterval.self, forKey: .date)
                let currentDate = Date(timeIntervalSince1970: dateInTimeInterval)
                date = dateFormatter.string(from: currentDate).uppercased()
                
                temp = try tempContainer.decode(Double.self, forKey: .day)
                weather = try weekDaysContainer.decode([Weather].self, forKey: .weather)
            }
        }
    }
}
