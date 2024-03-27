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
    @Published var searchBarText: String = ""
    private var cancellables =  Set<AnyCancellable>()
    
    let coinService = CoinDataService()
    
    init (){
        addSubscribe()
    }
    
    func addSubscribe() {
        $searchBarText.combineLatest(coinService.$allCoins)
            .debounce(for: .seconds(0.5),
                      scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoined = returnedCoins
            }.store(in: &cancellables)
    }
    
    func filterCoins(searchText: String, startingCoins: [Coin]) -> [Coin] {
        guard !searchText.isEmpty else {
            return startingCoins
        }
        
        let loweredText = searchText.lowercased()
        return startingCoins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(loweredText) ||
            coin.symbol.lowercased().contains(loweredText) ||
            coin.id.lowercased().contains(loweredText)
        }
    }
}
