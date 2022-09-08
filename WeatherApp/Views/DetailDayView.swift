//
//  DetailDayView.swift
//  WeatherApp
//
//  Created by Владимир Макаров on 30.05.2022.
//

import SwiftUI

struct DetailDayView: View {
    
    var description: String
    var value: Double
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(description)
                    .foregroundColor(Color.white)
                Text(description == "SUNRISE" || description == "SUNSET" ? WeatherLoader.prepareTimes(for: value) : "\(Int(value))")
                    .font(.title2)
                    .foregroundColor(Color.white)
            }
            
            Spacer()
        }
        .padding(.leading)
    }
}

struct DetailDayView_Previews: PreviewProvider {
    static var previews: some View {
        DetailDayView(description: "SUNRISE", value: 1)
    }
}
