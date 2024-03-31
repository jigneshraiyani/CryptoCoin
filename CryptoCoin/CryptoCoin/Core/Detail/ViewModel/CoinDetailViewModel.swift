//
//  CoinDetailViewModel.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/31/24.
//

import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {
    private let coinDetailService: CoinDetailDataService
    private var cancellable = Set<AnyCancellable>()
    
    init(coin: Coin) {
        coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribe()
    }
    
    private func addSubscribe() {
        coinDetailService.$coinDetails
            .sink { (returnedCoinDetail) in
            print(returnedCoinDetail)
        }
            .store(in: &cancellable)
    }
}
