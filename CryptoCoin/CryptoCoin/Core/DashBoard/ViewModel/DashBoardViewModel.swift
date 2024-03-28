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
    
    @Published var statistics: [Statistic] = []
    
    private var cancellables =  Set<AnyCancellable>()
    
    let coinService = CoinDataService()
    let marketDataService = MarketDataService()
    
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
        
        marketDataService.$marketData.map(mapGlobalMarketData)
            .sink { [weak self] (receivedStatistic) in
            self?.statistics = receivedStatistic
        }
        .store(in: &cancellables)

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
    
    private func mapGlobalMarketData(marketData: MarketData?) -> [Statistic] {
        var statistic: [Statistic] = []
        guard let data = marketData else { return statistic }
        let marketcap = Statistic(title: "Market Cap",
                                  value: data.marketCap,
                                  percentage: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume",
                               value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance",
                                     value: data.btcDominance)
        let portfolio = Statistic(title: "Portfolio Value",
                                  value: "$0.00",
                                  percentage: 0)
        statistic.append(contentsOf:
                            [marketcap, volume, btcDominance, portfolio])
        return statistic
    }
}
