//
//  ImageProcessor.swift
//  ColorTemperature
//
//  Created by Julius Adetya on 05/03/25.
//

import Foundation
import UIKit

class ImageProcessor {
    func adjustImageTemperature(
        inputPath: String,
        outputPath: String,
        temperatureAdjustment: Double
    ) throws {
        guard let inputImage = UIImage(contentsOfFile: inputPath) else {
            throw ImageProcessingError.invalidInputFile
        }
        
        guard let cgImage = inputImage.cgImage else {
            throw ImageProcessingError.cgImageConversionFailed
        }
        
        // OpenCV-based temperature adjustment (placeholder for actual implementation)
        let outputImage = performTemperatureAdjustment(
            inputImage: inputImage,
            temperatureValue: temperatureAdjustment
        )
        
        // Save processed image
        guard let jpegData = outputImage.jpegData(compressionQuality: 0.8) else {
            throw ImageProcessingError.imageSaveFailed
        }
        
        try jpegData.write(to: URL(fileURLWithPath: outputPath))
    }
    
    private func performTemperatureAdjustment(
        inputImage: UIImage,
        temperatureValue: Double
    ) -> UIImage {
        // Basic color temperature adjustment algorithm
        guard let cgImage = inputImage.cgImage else { return inputImage }
        
        let context = CIContext()
        let ciImage = CIImage(cgImage: cgImage)
        
        // Color matrix for temperature adjustment
        let redFactor = temperatureValue > 0 ?
            1.0 + (temperatureValue / 100.0) : 1.0
        let blueFactor = temperatureValue < 0 ?
            1.0 + (abs(temperatureValue) / 100.0) : 1.0
        
        let colorMatrix = CIVector(values: [
            redFactor, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, blueFactor, 0,
            0, 0, 0, 1
        ], count: 16)
        
        let colorFilter = CIFilter(name: "CIColorMatrix")
        colorFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        colorFilter?.setValue(colorMatrix, forKey: "inputRVector")
        colorFilter?.setValue(colorMatrix, forKey: "inputBVector")
        
        guard let outputCIImage = colorFilter?.outputImage else {
            return inputImage
        }
        
        guard let outputCGImage = context.createCGImage(
            outputCIImage,
            from: outputCIImage.extent
        ) else {
            return inputImage
        }
        
        return UIImage(cgImage: outputCGImage)
    }
}
