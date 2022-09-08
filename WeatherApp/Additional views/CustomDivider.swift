//
//  CustomDivider.swift
//  WeatherApp
//
//  Created by Владимир Макаров on 30.05.2022.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Divider()
            .frame(height: 1)
            .background(Color.white)
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
