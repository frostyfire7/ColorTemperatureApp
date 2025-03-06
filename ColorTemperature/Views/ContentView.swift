//
//  ContentView.swift
//  ColorTemperature
//
//  Created by Julius Adetya on 05/03/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @StateObject private var viewModel = ImageProcessingViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Image Selection or Display Area
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding()
                } else {
                    Button(action: { viewModel.showImagePicker = true }) {
                        VStack {
                            Image(systemName: "photo.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.blue)
                            Text("Upload Image")
                                .font(.headline)
                        }
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                
                // Temperature Adjustment Slider
                if viewModel.selectedImage != nil {
                    Slider(
                        value: $viewModel.temperatureAdjustment,
                        in: -100...100,
                        step: 1
                    )
                    .padding()
                    
                    Text("Temperature: \(Int(viewModel.temperatureAdjustment))°K")
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Button("Adjust Temperature") {
                            viewModel.adjustImageTemperature()
                        }
                        .padding()
                        .background(viewModel.selectedImage != nil ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(viewModel.selectedImage == nil)
                        
                        Button("Save Image") {
                            viewModel.saveImage()
                        }
                        .padding()
                        .background(viewModel.processedImage != nil ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(viewModel.processedImage == nil)
                        .alert(isPresented: $viewModel.showMessage) {
                            Alert(title: Text(viewModel.alertMessage))
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Color Temp Adjuster")
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(selectedImage: $viewModel.selectedImage)
            }
        }
    }
}
