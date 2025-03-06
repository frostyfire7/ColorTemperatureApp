//
//  ColorTemperatureApp.swift
//  ColorTemperature
//
//  Created by Julius Adetya on 05/03/25.
//

import SwiftUI

@main
struct ColorTemperatureApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ImageProcessingViewModel())
        }
    }
}
