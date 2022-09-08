//
//  MainWeatherStatusView.swift
//  WeatherApp
//
//  Created by Владимир Макаров on 30.05.2022.
//

import SwiftUI

struct MainWeatherStatusView: View {
    
    var mainWeather: MainWeatherData
    
    var body: some View {
        VStack {
            Text(mainWeather.cityName)
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.top)
            Text(mainWeather.weather[0].description.capitalized)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.white)
            Image(systemName: mainWeather.imageName)
                .renderingMode(.template)
                .resizable()
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: Configuration.mainWeatherPictureSize, height: Configuration.mainWeatherPictureSize)
            Text("\(Int(mainWeather.temp))°")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.white)
        }
    }
}

struct MainWeatherStatusView_Preview: PreviewProvider {
    static var previews: some View {
        MainWeatherStatusView(mainWeather: MainWeatherData())
    }
}
