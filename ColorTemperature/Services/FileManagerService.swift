//
//  FileManagerService.swift
//  ColorTemperature
//
//  Created by Julius Adetya on 05/03/25.
//

import Foundation

class FileManagerService {
    private let fileManager = FileManager.default
    
    func fileExists(atPath path: String) -> Bool {
        return fileManager.fileExists(atPath: path)
    }
    
    func validateImageFormat(path: String) -> Bool {
        let fileExtension = (path as NSString).pathExtension.lowercased()
        return AppConstants.supportedImageFormats.contains(fileExtension)
    }
    
    func validateFileSize(path: String) -> Bool {
        guard let attributes = try? fileManager.attributesOfItem(atPath: path),
              let fileSize = attributes[.size] as? Int else {
            return false
        }
        return fileSize <= AppConstants.maxImageSize
    }
    
    func createDirectory(at path: String) throws {
        try fileManager.createDirectory(
            atPath: path,
            withIntermediateDirectories: true,
            attributes: nil
        )
    }
}
