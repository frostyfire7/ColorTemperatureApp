//
//  ImageProcessingError.swift
//  ColorTemperature
//
//  Created by Julius Adetya on 05/03/25.
//

import Foundation

enum ImageProcessingError: Error {
    case invalidInputFile
    case cgImageConversionFailed
    case imageSaveFailed
    case unsupportedFormat
    case fileTooLarge
    
    var localizedDescription: String {
        switch self {
        case .invalidInputFile:
            return "Invalid input file"
        case .cgImageConversionFailed:
            return "Could not convert image"
        case .imageSaveFailed:
            return "Failed to save processed image"
        case .unsupportedFormat:
            return "Unsupported image format"
        case .fileTooLarge:
            return "Image file is too large"
        }
    }
}
