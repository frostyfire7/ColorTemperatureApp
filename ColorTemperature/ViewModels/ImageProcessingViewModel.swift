//
//  ImageProcessingViewModel.swift
//  ColorTemperature
//
//  Created by Julius Adetya on 05/03/25.
//

import SwiftUI
import PhotosUI

class ImageProcessingViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var processedImage: UIImage?
    @Published var showImagePicker = false
    @Published var temperatureAdjustment: Double = 0
    @Published var showMessage: Bool = false
    @Published var alertMessage: String = ""
    
    func adjustImageTemperature() {
        guard let inputImage = selectedImage else { return }
        
        // Use OpenCV bridge to adjust temperature
        processedImage = OpenCVBridge.adjustColorTemperature(
            inputImage,
            temperature: temperatureAdjustment
        )
        DispatchQueue.main.async {
            self.alertMessage = "Temperature adjusted!\n Please save the image"
            self.showMessage = true
        }
    }
    
    func saveImage() {
        guard let processedImage = processedImage else {
            print("Error: No processed image to save")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(processedImage, nil, nil, nil)
        print("Image successfully saved")
        DispatchQueue.main.async {
            self.alertMessage = "Image saved!\n Please check your photos"
            self.showMessage = true
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            print("Image saved successfully")
        }
    }
}
