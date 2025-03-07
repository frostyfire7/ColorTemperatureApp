//
//  ImageProcessingViewModel.swift
//  ColorTemperature
//
//  Created by Julius Adetya on 05/03/25.
//

import SwiftUI
import PhotosUI
import Combine

class ImageProcessingViewModel: ObservableObject {
    @Published var selectedImage: UIImage? {
        didSet {
            if selectedImage != nil && selectedImage != oldValue {
                processedImage = nil
                temperatureAdjustment = 0
                adjustImageTemperature()
            }
        }
    }
    @Published var processedImage: UIImage?
    @Published var showImagePicker = false
    @Published var temperatureAdjustment: Double = 0 {
        didSet {
            adjustImageTemperature()
        }
    }
    @Published var showMessage: Bool = false
    @Published var alertMessage: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $temperatureAdjustment
            .throttle(for: .milliseconds(10), scheduler: RunLoop.main, latest: true)
            .sink { [weak self] _ in
                self?.adjustImageTemperature()
            }
            .store(in: &cancellables)
    }
    
    func adjustImageTemperature() {
        guard let inputImage = selectedImage else { return }
        
        processedImage = nil
        
        // Use OpenCV bridge to adjust temperature
        autoreleasepool{
            processedImage = OpenCVBridge.adjustColorTemperature(
                inputImage,
                temperature: temperatureAdjustment
            )
        }
    }
    
    func saveImage() {
        guard let processedImage = processedImage else {
            print("Error: No processed image to save")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(processedImage, nil, nil, nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.alertMessage = "Please check your photos"
            self?.showMessage = true
        }
    }
    
    deinit {
        cancellables.removeAll()
        selectedImage = nil
        processedImage = nil
    }
}
