//
//  HomeViewModel.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/25/24.
//

import Foundation
import Combine

class DashBoardViewModel: ObservableObject {
    @Published var allCoined: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    private var cancellables =  Set<AnyCancellable>()
    
    let coinService = CoinDataService()
    
    init (){
        addSubscribe()
    }
    
    func addSubscribe() {
        coinService.$allCoins.sink { [weak self] (returnedCoins) in
            self?.allCoined = returnedCoins
        }
        .store(in: &cancellables)
    }
}
