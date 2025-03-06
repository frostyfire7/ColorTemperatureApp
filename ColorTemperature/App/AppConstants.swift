//
//  AppConstants.swift
//  ColorTemperature
//
//  Created by Julius Adetya on 05/03/25.
//

import Foundation

enum AppConstants {
    static let supportedImageFormats = ["jpg", "jpeg"]
    static let maxImageSize: Int = 10 * 1024 * 1024 // 10 MB
    static let temperatureRange = -100.0...100.0
    
    enum ErrorMessages {
        static let unsupportedFormat = "Only JPEG images are supported"
        static let fileTooLarge = "Image size exceeds maximum limit"
        static let invalidPath = "Invalid file path"
    }
}
