//
//  ImageConversionService.swift
//  ColorTemperature
//
//  Created by Julius Adetya on 05/03/25.
//

import UIKit
import CoreImage

class ImageConversionService {
    static func convertToUIImage(ciImage: CIImage) -> UIImage? {
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
    
    static func convertToCIImage(uiImage: UIImage) -> CIImage? {
        return CIImage(image: uiImage)
    }
}
