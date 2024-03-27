//
//  CoinImageViewModel.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/27/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: Coin
    private let coinImageService: CoinImageService
    private var cancellable = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        self.coinImageService = CoinImageService(coin: coin)
        self.isLoading = true
        self.addSubscribe()
    }
    
    private func addSubscribe() {
        self.coinImageService.$coinImage.sink { [weak self](_completion) in
            self?.isLoading = false
        } receiveValue: { [weak self] (receivedImage) in
            guard let self = self else { return }
            self.image = receivedImage
        }
        .store(in: &cancellable)
    }
    
}
