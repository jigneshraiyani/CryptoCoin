//
//  CoinImageService.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/27/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var coinImage: UIImage? = nil
    var coinImageCancellable: AnyCancellable?
    
    private let coin: Coin
    let folderName = "coin_images"
    private let fileManager = LocalFileManager.sharedInstane
    private let imageName: String
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: self.imageName,
                                                 folderName: folderName) {
            print("Image retrival from file manager")
            self.coinImage = savedImage
        } else {
            print("Downloading image")
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        coinImageCancellable = NetworkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] (receivedImage) in
                guard let self = self,
                      let downloadedImage = receivedImage else { return }
                self.coinImage = downloadedImage
                self.coinImageCancellable?.cancel()
                self.fileManager.saveImage(image: downloadedImage,
                                           imageName: self.imageName,
                                           folderName: self.folderName)
            })
    }
    
}
