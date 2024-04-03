//
//  HomeViewModel.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/25/24.
//

import Foundation
import Combine

class DashBoardViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchBarText: String = ""
    @Published var isLoading: Bool = false
    @Published var statistics: [Statistic] = []
    @Published var sortingOption: SortOption = .holding
    
    enum SortOption {
        case rank, rankReversed, price, priceReversed, holding, holdingReversed
    }
    
    private var cancellables =  Set<AnyCancellable>()
    
    private let coinService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataServie = PortfolioDataService()
    init (){
        addSubscribe()
    }
    
    func addSubscribe() {
        $searchBarText.combineLatest(coinService.$allCoins,
                                     $sortingOption)
            .debounce(for: .seconds(0.5),
                      scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(portfolioDataServie.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (receivedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinIfNeeded(coins: receivedCoins)
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (receivedStatistic) in
                self?.statistics = receivedStatistic
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: Coin,
                         amount: Double) {
        portfolioDataServie.updatePortfolio(coin: coin,
                                            amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    func filterAndSortCoins(searchText: String,
                            startingCoins: [Coin],
                            sort: SortOption) -> [Coin] {
        var filterCoins = filterCoins(searchText: searchText,
                                      startingCoins: startingCoins)
        sortCoins(sort: sort,
                  coin: &filterCoins)
        return filterCoins
    }
    
    private func filterCoins(searchText: String,
                     startingCoins: [Coin]) -> [Coin] {
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
    
    private func sortCoins(sort: SortOption,
                           coin: inout [Coin]) {
        switch sort {
        case .rank, .holding:
             coin.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingReversed:
             coin.sort(by: { $0.rank > $1.rank })
        case .price:
             coin.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
             coin.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    private func sortPortfolioCoinIfNeeded(coins: [Coin]) -> [Coin] {
        switch sortingOption {
        case .holding:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [Coin],
                                             portfolioEntities: [PortfolioEntity]) -> [Coin] {
        allCoins
            .compactMap { (coin) -> Coin? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHolding(amount: entity.amount)
            }
    }
            
    private func mapGlobalMarketData(marketData: MarketData?,
                                     portfolioCoins: [Coin]) -> [Statistic] {
        var statistic: [Statistic] = []
        guard let data = marketData else { return statistic }
        let marketcap = Statistic(title: "Market Cap",
                                  value: data.marketCap,
                                  percentage: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume",
                               value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance",
                                     value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map({ $0.currentHoldingsValue })
            .reduce(0, +)
        
        let previousValue =
        portfolioCoins
            .map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
        .reduce(0, +)

        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        
        let portfolio = Statistic(title: "Portfolio Value",
                                  value: portfolioValue.convertCurrencyWith2Decimal(),
                                  percentage: percentageChange)
        statistic.append(contentsOf:
                            [marketcap, volume, btcDominance, portfolio])
        return statistic
    }
}
