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
    
    init(imageURL: String) {
        getCoinImage(imageURL: imageURL)
    }
    
    private func getCoinImage(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        coinImageCancellable = NetworkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] (receivedImage) in
                guard let self = self else { return }
                self.coinImage = receivedImage
                self.coinImageCancellable?.cancel()
            })
    }
    
}
