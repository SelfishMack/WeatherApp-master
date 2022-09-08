//
//  WeatherDayView.swift
//  WeatherApp
//
//  Created by Владимир Макаров on 30.05.2022.
//

import SwiftUI

struct WeatherDayView: View {
    
    var day: WeekDay
    
    var body: some View {
        VStack {
            Text(String(day.date))
                .font(.system(size: Configuration.weekdayFontSize, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: day.imageName)
                .renderingMode(.template)
                .resizable()
                .foregroundColor(.white)
                .accentColor(.green)
                .aspectRatio(contentMode: .fit)
                .frame(width: Configuration.weekdayImageSize, height: Configuration.weekdayImageSize)
            Text("\(Int(day.temp))°")
                .font(.title2)
                .foregroundColor(.white)
        }
    }
}
