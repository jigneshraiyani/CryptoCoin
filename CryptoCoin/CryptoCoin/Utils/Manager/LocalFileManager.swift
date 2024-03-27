//
//  LocalFileManager.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/27/24.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let sharedInstane = LocalFileManager()
    private init() {}
    
    func saveImage(image: UIImage,
                   imageName: String,
                   folderName: String) {
        // create foler
        createFolderIfNeeded(folderName: folderName)
        
        // get path for image
        guard let data = image.pngData(),
              let url = getURLforImage(imageName: imageName,
                                       folderName: folderName) else {
            return
        }
        
        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error save image \(error.localizedDescription)")
        }
    }
    
    func getImage(imageName: String,
                  folderName: String) -> UIImage? {
        guard let url = getURLforImage(imageName: imageName,
                                       folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLforFolder(folderName: folderName) else {
            return
        }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            } catch let error {
                print("Error creating directory, folderName: \(folderName). \(error.localizedDescription)")
            }
        }
    }
    
    private func getURLforFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory,
                                                 in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLforImage(imageName: String,
                                folderName: String) -> URL? {
        guard let folderURL = self.getURLforFolder(folderName: folderName) else { return nil }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
